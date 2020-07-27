import 'package:commercio_ui/commercio_ui.dart';

String accountRequestResponseToString(
  AccountRequestResponse accountRequestResponse,
) {
  final hash =
      RegExp(r'[\w]+').allMatches(accountRequestResponse.message).last.group(0);
  final error = accountRequestResponse.message;

  return accountRequestResponse.isSuccess
      ? 'Success! Hash: $hash'
      : 'Error: $error';
}
