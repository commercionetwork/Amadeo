import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:amadeo_flutter/widgets/recipient_address_text_field_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                SendTokensWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SendTokensWidget extends StatelessWidget {
  SendTokensWidget({
    this.defaultAmount = '100',
    this.defaultDenom = 'ucommercio',
  })  : amountTextController = TextEditingController(text: defaultAmount),
        denomTextController = TextEditingController(text: defaultDenom);

  final String defaultAmount;
  final String defaultDenom;
  final TextEditingController recipientTextController = TextEditingController();
  final TextEditingController amountTextController;
  final TextEditingController denomTextController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          RecipientAddressTextFieldWidget(
            recipientTextController: recipientTextController,
          ),
          TextField(
            controller: amountTextController,
            decoration: InputDecoration(
              hintText: defaultAmount,
              labelText: 'Amount of tokens',
            ),
          ),
          TextField(
            controller: denomTextController,
            decoration: InputDecoration(
              hintText: defaultDenom,
              labelText: 'Amount denom',
            ),
          ),
          const ParagraphWidget(
            'Press the button to send the selected amount of coins.',
            padding: EdgeInsets.all(5.0),
          ),
          SendTokensFlatButton(
            accountEventCallback: () => CommercioAccountSendTokensEvent(
              recipientAddress:
                  recipientTextController.text.split(',')[0].trim(),
              amount: [
                sdk.StdCoin(
                    denom: denomTextController.text,
                    amount: amountTextController.text)
              ],
            ),
            child: () => const Text('Send tokens',
                style: TextStyle(color: Colors.white)),
            loadingChild: () => const Text(
              'Sending...',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SendTokensTextField(
              loadingTextCallback: () => 'Sending...',
              textCallback: (state) => state.result.success
                  ? 'Success! Hash: ${state.result.hash}'
                  : 'Error: ${jsonEncode(state.result.error)}',
            ),
          ),
        ],
      ),
    );
  }
}
