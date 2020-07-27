import 'dart:convert';

import 'package:commercio_ui/commercio_ui.dart';

String commercioKeysToString(CommercioIdKeys commercioIdKeys) {
  return jsonEncode(commercioIdKeys);
}
