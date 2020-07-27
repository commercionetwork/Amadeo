import 'package:commercio_ui/commercio_ui.dart';

String faucetInviteResponseToString(FaucetInviteResponse response) {
  return response.success
      ? 'Success! Hash: ${response.txHash}'
      : 'Error: ${response.error}';
}
