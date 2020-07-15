import 'dart:convert';

import 'package:commerciosdk/entities/id/request_did_power_up.dart';

String powerUpRequestToString(RequestDidPowerUp requestDidPowerUp) {
  return jsonEncode(requestDidPowerUp);
}
