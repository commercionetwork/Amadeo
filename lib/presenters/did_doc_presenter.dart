import 'dart:convert';

import 'package:commerciosdk/export.dart';

String didDocumentToString(DidDocument didDocument) {
  return jsonEncode(didDocument);
}
