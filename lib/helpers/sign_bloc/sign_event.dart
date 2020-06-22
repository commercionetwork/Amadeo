part of 'sign_bloc.dart';

abstract class SignEvent extends Equatable {
  const SignEvent();
}

class SignLoadDocumentEvent extends SignEvent {
  const SignLoadDocumentEvent();

  @override
  List<Object> get props => [];
}

class SignDocumentEvent extends SignEvent {
  final CommercioDocMetadata metadata;
  final List<CommercioSdnData> sdnData;
  final List<String> recipients;
  final StdFee fee;
  final String certificateProfile;
  final String contentUri;
  final String docId;
  final String signerIstance;
  final String storageUri;
  final String vcrId;
  final String walletAddress;

  const SignDocumentEvent({
    @required this.certificateProfile,
    @required this.contentUri,
    @required this.docId,
    @required this.metadata,
    @required this.recipients,
    @required this.signerIstance,
    @required this.storageUri,
    @required this.vcrId,
    @required this.walletAddress,
    this.sdnData,
    this.fee,
  });

  @override
  List<Object> get props => [
        certificateProfile,
        contentUri,
        docId,
        fee,
        metadata,
        recipients,
        sdnData,
        storageUri,
        vcrId,
        walletAddress,
      ];
}

class SignGenerateNewDocUuid extends SignEvent {
  const SignGenerateNewDocUuid();

  @override
  List<Object> get props => [];
}
