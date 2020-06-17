import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

class SendReceiptPage extends SectionPageWidget {
  const SendReceiptPage({Key key})
      : super('/3-docs/send-receipt', 'SendReceiptPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: SendReceiptPageBody(),
    );
  }
}

class SendReceiptPageBody extends StatelessWidget {
  const SendReceiptPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                SendReceiptWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SendReceiptWidget extends StatelessWidget {
  final TextEditingController recipientTextController = TextEditingController();
  final TextEditingController txHashController = TextEditingController();
  final TextEditingController docIdController = TextEditingController();

  SendReceiptWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          RecipientAddressTextFieldWidget(
            recipientTextController: recipientTextController,
          ),
          TextField(
            decoration: const InputDecoration(
                hintText:
                    'BC5810E7A8FD7E057A8EA56152D4C8EF1F38CE235D8DAF179AFD7B75B0415695',
                labelText: 'Transaction hash'),
            controller: txHashController,
          ),
          TextField(
            decoration: const InputDecoration(
                hintText: '28cdad1b-9289-4a4a-985e-3a44a1c3ba9b',
                labelText: 'Document id'),
            controller: docIdController,
          ),
          const ParagraphWidget(
            'Press the button to send a receipt to the inseted hash and docId.',
            padding: EdgeInsets.all(5.0),
          ),
          SendReceiptFlatButton(
            accountEventCallback: () => CommercioDocsSendReceiptEvent(
              recipient: recipientTextController.text,
              txHash: txHashController.text,
              docId: docIdController.text,
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Sending...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Send receipt',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SendReceiptTextField(
              readOnly: true,
              loadingTextCallback: () => 'Sending...',
              textCallback: (state) => state.transactionResult.success
                  ? 'Success! Hash: ${state.transactionResult.hash}'
                  : 'Error: ${jsonEncode(state.transactionResult.error)}',
            ),
          ),
        ],
      ),
    );
  }
}
