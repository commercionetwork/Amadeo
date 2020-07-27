import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/balance_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckAccountBalancePage extends SectionPageWidget {
  const CheckAccountBalancePage({Key key})
      : super(
          '/1-account/check-account-balance',
          'CheckAccountBalancePage',
          key: key,
        );

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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioAccountCheckBalanceBloc(
            commercioAccount: RepositoryProvider.of<StatefulCommercioAccount>(
              context,
            ),
          ),
          child: const CheckAccountBalanceWidget(),
        ),
      ],
    );
  }
}

class CheckAccountBalanceWidget extends StatelessWidget {
  const CheckAccountBalanceWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to check the account balance.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: CheckBalanceFlatButton(
                event: () => const CommercioAccountCheckBalanceEvent(),
                child: (_) => const Text(
                  'Check balance',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
              ),
            ),
          ),
          CheckBalanceTextField(
            loading: (_) => 'Checking...',
            text: (_, state) => balanceToString(state.balance),
          ),
        ],
      ),
    );
  }
}
