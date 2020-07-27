import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class DocumentRepository {
  final AssetBundle assetBundle;
  final String documentPath;
  String documentContent;
  String docId;

  DocumentRepository({
    AssetBundle assetBundle,
    String documentPath,
  })  : assetBundle = assetBundle ?? rootBundle,
        documentPath = documentPath ?? './assets/document.txt',
        docId = '';

  bool get hasLoadedDocument => documentContent != null;

  bool get hasNotLoadedDocument => !hasLoadedDocument;

  bool get hasDocIdGenerated => docId.isNotEmpty;

  bool get hasNotDocIdGenerated => !hasDocIdGenerated;

  Future<ByteData> fetchDocument() => assetBundle.load(documentPath);

  Future<String> fetchContent() async =>
      documentContent = await assetBundle.loadString(documentPath);

  String generateNewDocId() => docId = Uuid().v4();
}
