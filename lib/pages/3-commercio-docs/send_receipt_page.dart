import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendReceiptPage extends SectionPageWidget {
  const SendReceiptPage({Key key})
      : super('/3-docs/send-receipt', 'SendReceiptPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioDocsDeriveReceiptBloc(
          commercioDocs: RepositoryProvider.of<StatefulCommercioDocs>(context),
          commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
        ),
        child: const SendReceiptPageBody(),
      ),
    );
  }
}

class SendReceiptPageBody extends StatelessWidget {
  const SendReceiptPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        const DeriveReceiptWidget(),
        BlocProvider(
          create: (_) => CommercioDocsSendReceiptsBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: const SendReceiptWidget(),
        ),
      ],
    );
  }
}

class DeriveReceiptWidget extends StatefulWidget {
  const DeriveReceiptWidget();

  @override
  _DeriveReceiptWidgetState createState() => _DeriveReceiptWidgetState();
}

class _DeriveReceiptWidgetState extends State<DeriveReceiptWidget> {
  final _recipientTextController = TextEditingController();
  final _txHashController = TextEditingController();
  final _docIdController = TextEditingController();

  @override
  void dispose() {
    _recipientTextController.dispose();
    _txHashController.dispose();
    _docIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecipientAddressTextFieldWidget(
            recipientTextController: _recipientTextController,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText:
                  'BC5810E7A8FD7E057A8EA56152D4C8EF1F38CE235D8DAF179AFD7B75B0415695',
              labelText: 'Transaction hash',
            ),
            controller: _txHashController,
            maxLines: null,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: '28cdad1b-9289-4a4a-985e-3a44a1c3ba9b',
              labelText: 'Document id',
            ),
            controller: _docIdController,
            maxLines: null,
          ),
          const ParagraphWidget(
            'Press the button derive a receipt to the inseted hash and docId.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: DeriveReceiptFlatButton(
                event: () => CommercioDocsDeriveReceiptEvent(
                  recipient: _recipientTextController.text,
                  txHash: _txHashController.text,
                  documentId: _docIdController.text,
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
                child: (_) => const Text(
                  'Derive receipt',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          DeriveReceiptTextField(
            loading: (_) => 'Deriving...',
            text: (_, state) => jsonEncode(state.commercioDocReceipt),
          ),
        ],
      ),
    );
  }
}

class SendReceiptWidget extends StatelessWidget {
  const SendReceiptWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to send the previously generated receipt.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: BlocBuilder<CommercioDocsDeriveReceiptBloc,
                  CommercioDocsDeriveReceiptState>(
                builder: (_, state) {
                  final fn = (state is CommercioDocsDeriveReceiptStateData)
                      ? () => CommercioDocsSendReceiptsEvent(
                            commercioDocReceipts: [state.commercioDocReceipt],
                          )
                      : null;

                  return SendReceiptsFlatButton(
                    event: fn,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).disabledColor,
                    child: (_) => const Text(
                      'Send receipt',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          SendReceiptsTextField(
            loading: (_) => 'Sending...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
