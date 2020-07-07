import 'package:sacco/sacco.dart';

String balanceToString(List<StdCoin> balance) {
  return balance.fold(
    '',
    (prev, curr) =>
        '$prev ${prev.isEmpty ? '' : ','} Amount ${curr.amount} of ${curr.denom}',
  );
}
