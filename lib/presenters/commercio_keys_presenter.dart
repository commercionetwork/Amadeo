import 'dart:convert';

import 'package:commercio_ui/entities/commercio_id_keys.dart';

String commercioKeysToString(CommercioIdKeys commercioIdKeys) {
  return jsonEncode(commercioIdKeys);
}
