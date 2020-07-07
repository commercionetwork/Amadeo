import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioDocsSentReceiptsBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: const SentReceiptsWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioDocsReceivedReceiptsBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: const ReceivedReceiptsWidget(),
        ),
      ],
    );
  }
}

class SentReceiptsWidget extends StatelessWidget {
  const SentReceiptsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the sent receipts.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: SentReceiptsFlatButton(
                event: () => const CommercioDocsSentReceiptsEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Sent Receipts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SentReceiptsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.sentReceipts.fold(
                '',
                (prev, curr) =>
                    '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the received receipts.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: ReceivedReceiptsFlatButton(
                event: () => const CommercioDocsReceivedReceiptsEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Received Receipts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ReceivedReceiptsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.receivedReceipts.fold(
                '',
                (prev, curr) =>
                    '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
          ),
        ],
      ),
    );
  }
}
