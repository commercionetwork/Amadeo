import 'dart:convert';

import 'package:commerciosdk/export.dart';

String commercioDocToString(CommercioDoc commercioDoc) {
  return jsonEncode(commercioDoc);
}
