import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class ReceiptListPage extends SectionPageWidget {
  const ReceiptListPage({Key? key})
      : super('/3-docs/receipt-list', 'ReceiptListPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: ReceiptListPageBody(),
    );
  }
}

class ReceiptListPageBody extends StatelessWidget {
  const ReceiptListPageBody({Key? key}) : super(key: key);

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

class SentReceiptsWidget extends StatefulWidget {
  const SentReceiptsWidget({Key? key}) : super(key: key);

  @override
  _SentReceiptsWidgetState createState() => _SentReceiptsWidgetState();
}

class _SentReceiptsWidgetState extends State<SentReceiptsWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.text =
        context.read<StatefulCommercioAccount>().walletAddress ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
              labelText: 'Wallet address',
            ),
            controller: _textController,
          ),
          const ParagraphWidget(
            'Press the button to get a list of the sent receipts from the selected address.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: SentReceiptsFlatButton(
                event: () => CommercioDocsSentReceiptsEvent(
                  walletAddress: _textController.text,
                ),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Sent Receipts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SentReceiptsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.maybeWhen(
              (sentReceipts) => sentReceipts.fold(
                  '',
                  (prev, curr) =>
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedReceiptsWidget extends StatefulWidget {
  const ReceivedReceiptsWidget({Key? key}) : super(key: key);

  @override
  _ReceivedReceiptsWidgetState createState() => _ReceivedReceiptsWidgetState();
}

class _ReceivedReceiptsWidgetState extends State<ReceivedReceiptsWidget> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.text =
        context.read<StatefulCommercioAccount>().walletAddress ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
              labelText: 'Wallet address',
            ),
            controller: _textController,
          ),
          const ParagraphWidget(
            'Press the button to get a list of the received receipts to the selected address.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: ReceivedReceiptsFlatButton(
                event: () => CommercioDocsReceivedReceiptsEvent(
                  walletAddress: _textController.text,
                ),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Received Receipts',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ReceivedReceiptsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.maybeWhen(
              (receivedReceipts) => receivedReceipts.fold(
                  '',
                  (prev, curr) =>
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
