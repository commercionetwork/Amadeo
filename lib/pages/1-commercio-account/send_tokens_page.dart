import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendTokensPage extends SectionPageWidget {
  const SendTokensPage({Key key})
      : super('/1-account/send-tokens', 'SendTokensPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: SendTokensPageBody());
  }
}

class SendTokensPageBody extends StatelessWidget {
  const SendTokensPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioAccountSendTokensBloc(
            commercioAccount: RepositoryProvider.of<StatefulCommercioAccount>(
              context,
            ),
          ),
          child: const SendTokensWidget(),
        ),
      ],
    );
  }
}

class SendTokensWidget extends StatefulWidget {
  const SendTokensWidget({
    this.defaultAmount = '100',
    this.defaultDenom = 'ucommercio',
  });

  final String defaultAmount;
  final String defaultDenom;

  @override
  _SendTokensWidgetState createState() => _SendTokensWidgetState();
}

class _SendTokensWidgetState extends State<SendTokensWidget> {
  final _recipientTextController = TextEditingController(
    text: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau,',
  );
  TextEditingController _amountTextController;
  TextEditingController _denomTextController;

  @override
  void initState() {
    _amountTextController = TextEditingController(text: widget.defaultAmount);
    _denomTextController = TextEditingController(text: widget.defaultDenom);
    super.initState();
  }

  @override
  void dispose() {
    _recipientTextController.dispose();
    _amountTextController.dispose();
    _denomTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          RecipientAddressTextFieldWidget(
            recipientTextController: _recipientTextController,
          ),
          TextField(
            controller: _amountTextController,
            decoration: InputDecoration(
              hintText: widget.defaultAmount,
              labelText: 'Amount of tokens',
            ),
          ),
          TextField(
            controller: _denomTextController,
            decoration: InputDecoration(
              hintText: widget.defaultDenom,
              labelText: 'Amount denom',
            ),
          ),
          const ParagraphWidget(
            'Press the button to send the selected amount of coins.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SendTokensFlatButton(
              event: () => CommercioAccountSendTokensEvent(
                recipientAddress:
                    _recipientTextController.text.split(',')[0].trim(),
                amount: [
                  sdk.StdCoin(
                    denom: _denomTextController.text,
                    amount: _amountTextController.text,
                  ),
                ],
              ),
              child: (_) => const Text(
                'Send tokens',
                style: TextStyle(color: Colors.white),
              ),
              loading: (_) => const Text(
                'Sending...',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).disabledColor,
            ),
          ),
          SendTokensTextField(
            loading: (_) => 'Sending...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
