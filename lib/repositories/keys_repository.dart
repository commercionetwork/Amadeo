import 'dart:convert';

import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/services.dart';

class KeysRepository {
  final String _demoKeysPath;

  const KeysRepository({String demoKeysPath})
      : _demoKeysPath = demoKeysPath ?? 'assets/id_keys.json';

  Future<CommercioIdKeys> fetchDemoKeys() async {
    final rsaKeysRaw = await rootBundle.loadString(_demoKeysPath);
    final decodedJson = jsonDecode(rsaKeysRaw) as Map<String, dynamic>;

    return CommercioIdKeys.fromJson(decodedJson);
  }
}
