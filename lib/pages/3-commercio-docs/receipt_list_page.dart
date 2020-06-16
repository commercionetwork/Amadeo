import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

class ReceiptListPage extends SectionPageWidget {
  const ReceiptListPage({Key key})
      : super('/3-docs/receipt-list', 'ReceiptListPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: ReceiptListPageBody(),
    );
  }
}

class ReceiptListPageBody extends StatelessWidget {
  const ReceiptListPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                SentReceiptsWidget(),
                ReceivedReceiptsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SentReceiptsWidget extends StatelessWidget {
  const SentReceiptsWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the sent receipts.',
            padding: EdgeInsets.all(5.0),
          ),
          SentReceiptsFlatButton(
            accountEventCallback: () => const CommercioDocsSentReceiptsEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Sent Receipts',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SentReceiptsTextField(
              readOnly: true,
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.sentReceipts.fold(
                  '',
                  (prev, curr) =>
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedReceiptsWidget extends StatelessWidget {
  const ReceivedReceiptsWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the received receipts.',
            padding: EdgeInsets.all(5.0),
          ),
          ReceivedReceiptsFlatButton(
            accountEventCallback: () =>
                const CommercioDocsReceivedReceiptsEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Received Receipts',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ReceivedReceiptsTextField(
              readOnly: true,
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.receivedReceipts.fold(
                  '',
                  (prev, curr) =>
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
            ),
          ),
        ],
      ),
    );
  }
}
