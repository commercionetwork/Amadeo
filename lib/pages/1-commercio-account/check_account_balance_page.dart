import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

class CheckAccountBalancePage extends SectionPageWidget {
  const CheckAccountBalancePage({Key key})
      : super('/1-account/check-account-balance', 'CheckAccountBalancePage',
            key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: CheckAccountBalancePageBody(),
    );
  }
}

class CheckAccountBalancePageBody extends StatelessWidget {
  const CheckAccountBalancePageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                CheckAccountBalanceWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CheckAccountBalanceWidget extends StatelessWidget {
  const CheckAccountBalanceWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to check the account balance.',
            padding: EdgeInsets.all(5.0),
          ),
          CheckBalanceFlatButton(
            child: () => const Text(
              'Check balance',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Checking...',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CheckBalanceTextField(
                loadingTextCallback: () => 'Checking...',
                textCallback: (state) => state.balance.fold(
                    '',
                    (prev, curr) =>
                        '$prev ${prev.isEmpty ? '' : ','} Amount ${curr.amount} of ${curr.denom}')),
          ),
        ],
      ),
    );
  }
}
