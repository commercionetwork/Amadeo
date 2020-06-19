import 'package:flutter/services.dart';

class DocumentRepository {
  final AssetBundle assetBundle;
  final String documentPath;

  DocumentRepository({
    AssetBundle assetBundle,
    String documentPath,
  })  : assetBundle = assetBundle ?? rootBundle,
        documentPath = documentPath ?? './assets/document.txt';

  Future<ByteData> fetchDocument() => assetBundle.load(documentPath);

  Future<String> fetchContent() => assetBundle.loadString(documentPath);
}
