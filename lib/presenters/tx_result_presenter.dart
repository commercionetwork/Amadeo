import 'package:commerciosdk/export.dart';

String txResultToString(TransactionResult txResult) {
  if (txResult.success) {
    return 'Success! Hash: ${txResult.hash}';
  }

  return 'Error ${txResult.error.errorCode}: ${txResult.error.errorMessage}';
}
