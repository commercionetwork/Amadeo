import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
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
              children: const [
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
  const SendTokensWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to send 100 ucommercio coins.',
            padding: EdgeInsets.all(5.0),
          ),
          SendTokensFlatButton(
            child: () => const Text('Send tokens',
                style: TextStyle(color: Colors.white)),
            loadingChild: () => const Text(
              'Sending...',
              style: TextStyle(color: Colors.white),
            ),
            recipientAddress: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
            amount: const [CommercioCoin(amount: '100')],
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
