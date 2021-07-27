import 'dart:async';
import 'dart:convert';
//import 'dart:typed_data';

//import 'package:amadeo/entities/dsb_result.dart';
import 'package:amadeo/helpers/sign_constants.dart';
import 'package:amadeo/repositories/document_repository.dart';
//import 'package:asn1lib/asn1lib.dart';
//import 'package:basic_utils/basic_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:commercio_ui/commercio_ui.dart';
//import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
//import 'package:encrypt/encrypt.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
//import 'package:pointycastle/pointycastle.dart' show RSAPublicKey hide Digest;

part 'sign_event.dart';
part 'sign_state.dart';

class SignBloc extends Bloc<SignEvent, SignState> {
  final Client client;
  final String dsbUrl;
  final String dsbPort;
  final String dsbSignerAddress;
  final StatefulCommercioDocs commercioDocs;
  final StatefulCommercioId commercioId;
  final DocumentRepository documentRepository;

  SignBloc({
    required this.dsbSignerAddress,
    required this.commercioDocs,
    required this.commercioId,
    required this.documentRepository,
    Client? client,
    String? dsbUrl,
    String? dsbPort,
  })  : client = client ?? Client(),
        dsbUrl = dsbUrl ?? 'localhost',
        dsbPort = dsbPort ?? '9999',
        super(const SignInitial());

  crypto.Digest sha256Digest(String value) {
    final valueAsBytes = utf8.encode(value);

    return crypto.sha256.convert(valueAsBytes);
  }

  @override
  Stream<SignState> mapEventToState(
    SignEvent event,
  ) async* {
    if (event is SignLoadDocumentEvent) {
      yield* _mapSignLoadDocumentEventToState(event);
    }

    if (event is SignGenerateNewDocUuid) {
      yield* _mapSignGenerateNewDocUuidToState(event);
    }

    if (event is SignDocumentEvent) {
      yield* _mapSignDocumentEventToState(event);
    }
  }

  Stream<SignState> _mapSignLoadDocumentEventToState(
    SignLoadDocumentEvent event,
  ) async* {
    yield const SignLoadDocumentLoading();

    final documentContent = await documentRepository.fetchContent();

    try {
      yield SignDocumentLoaded(content: documentContent, hash: 'hash');
    } catch (e) {
      yield SignLoadDocumentError(e.toString());
    }
  }

  Stream<SignState> _mapSignGenerateNewDocUuidToState(
    SignGenerateNewDocUuid event,
  ) async* {
    yield const SignNewDocUuidLoading();

    try {
      yield NewDocUuid(docId: documentRepository.generateNewDocId());
    } catch (e) {
      yield SignNewDocUuidError(e.toString());
    }
  }

  Stream<SignState> _mapSignDocumentEventToState(
    SignDocumentEvent event,
  ) async* {
    yield const SignDocumentLoading();

    try {
      if (documentRepository.hasNotDocIdGenerated) {
        throw Exception(
          'Error: a document id should be generated before share a document.',
        );
      }

      if (documentRepository.hasNotLoadedDocument) {
        throw Exception('Error: document not loaded.');
      }

      await _addDocument(docId: event.docId);

      final digest = sha256Digest(documentRepository.documentContent!);

      final shareDocResult = await _shareDocument(
        recipients: event.recipients,
        docId: event.docId,
        contentUri: event.contentUri,
        metadata: event.metadata,
        sdnData: event.sdnData,
        digest: digest,
        fee: event.fee,
      );

      if (!shareDocResult.success) {
        throw Exception(
          'Error while sharing the document (${shareDocResult.error?.errorCode}): ${shareDocResult.error?.errorMessage}',
        );
      }

      final getUri = Uri.http(
        '$dsbUrl:$dsbPort',
        '${DsbEndpoint.get.value}/${event.docId}',
      );

      yield SignedDocument(
        result:
            'Get the generated certificate and signed hash at:\n\n${getUri.toString()}',
      );

      /*final getResult = await _retrieveDocument(docId: event.docId);

      final verified = _verifySignature(dsbResult: getResult, digest: digest);

      yield SignedDocument(
        result: verified
            ? 'Document signed, shared and verified'
            : 'Document signed, shared but not verified',
      );*/
    } catch (e) {
      yield SignDocumentError(e.toString());
    }
  }

  Future<Response> _addDocument({
    required String docId,
  }) async {
    final uri = Uri.http('$dsbUrl:$dsbPort', DsbEndpoint.add.value);
    final result = await client.post(uri, headers: {
      DsbHeader.xDid.value: dsbSignerAddress,
      DsbHeader.xResource.value: docId,
    });

    if (result.statusCode != 200) {
      throw Exception(
          'Http Exception: ${result.body.isNotEmpty ? result.body : result.reasonPhrase}');
    }

    return result;
  }

  Future<TransactionResult> _shareDocument({
    required List<String> recipients,
    required String docId,
    required String contentUri,
    required CommercioDocMetadata metadata,
    required Set<CommercioSdnData>? sdnData,
    required crypto.Digest digest,
    required StdFee? fee,
  }) async {
    final storageUri =
        Uri.http('$dsbUrl:$dsbPort', '${DsbEndpoint.upload.value}/$docId');

    final commDoc = await commercioDocs.deriveCommercioDocument(
      docId: docId,
      contentUri: contentUri,
      doSign: CommercioDoSign(
        storageUri: storageUri.toString(),
        signerIstance: dsbSignerAddress,
        sdnData: sdnData,
        vcrId: 'xxxxx',
        certificateProfile: 'xxxxx',
      ),
      recipients: recipients,
      metadata: metadata,
      checksum: CommercioDocChecksum(
        value: digest.toString(),
        algorithm: CommercioDocChecksumAlgorithm.SHA256,
      ),
    );

    return commercioDocs.shareDocuments(
      commercioDocs: [commDoc],
      fee: fee,
    );
  }

  /*Future<DsbResult> _retrieveDocument({
    required String docId,
  }) async {
    final uri = Uri.http('$dsbUrl:$dsbPort', '${DsbEndpoint.get.value}/$docId');
    Response result;

    do {
      result = await client.get(uri);
    } while (result.statusCode == 404);

    if (result.statusCode != 200) {
      throw Exception(
          'Http Exception: ${result.body.isNotEmpty ? result.body : result.reasonPhrase}');
    }

    return DsbResult.fromJson(jsonDecode(result.body) as Map<String, dynamic>);
  }

  bool _verifySignature({
    required DsbResult dsbResult,
    required crypto.Digest digest,
  }) {
    final decodedCert = base64Decode(dsbResult.cert);
    final certPem = utf8.decode(decodedCert);
    final X509CertificateData cert = X509Utils.x509CertificateFromPem(certPem);

    final pubKey = _hexStringToPublicKey(cert.publicKeyData.bytes);

    final verifier = Signer(RSASigner(RSASignDigest.SHA256, publicKey: pubKey));
    final res =
        verifier.verify(digest.toString(), Encrypted.from64(dsbResult.hash));

    return res;
  }

  RSAPublicKey _hexStringToPublicKey(String hexStr) {
    final bytes = hex.decode(hexStr);
    final publicKeyAsn = ASN1Parser(Uint8List.fromList(bytes));
    final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
    final modulus = publicKeySeq.elements[0] as ASN1Integer;
    final exponent = publicKeySeq.elements[1] as ASN1Integer;

    final rsaPublicKey =
        RSAPublicKey(modulus.valueAsBigInteger, exponent.valueAsBigInteger);

    return rsaPublicKey;
  }*/
}
