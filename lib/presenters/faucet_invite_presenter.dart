import 'package:commercio_ui/entities/faucet_invite_response.dart';

String faucetInviteResponseToString(FaucetInviteResponse response) {
  return response.success
      ? 'Success! Hash: ${response.txHash}'
      : 'Error: ${response.error}';
}
