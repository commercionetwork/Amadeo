import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/docs/export.dart';
import 'package:commerciosdk/entities/docs/commercio_doc.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommercioDocsPage extends SectionPageWidget {
  const CommercioDocsPage({Key key})
      : super(Routes.commercioDocsPage, 'CommercioDocsPage', key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioDocsBloc>(
      create: (_) => CommercioDocsBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioDocsBody()),
    );
  }
}

class CommercioDocsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                ShareDocWidget(),
                ShareEncDocWidget(),
                const SendReceiptWidget(),
                const SentDocumentsWidget(),
                const ReceivedDocumentsWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShareDocWidget extends StatelessWidget {
  final sdk.CommercioDocMetadata metadata;
  final List<String> recipients;

  ShareDocWidget()
      : metadata = sdk.CommercioDocMetadata(
          contentUri: 'https://example.com/document/metadata',
          schema: CommercioDocMetadataSchema(
            uri: 'https://example.com/custom/metadata/schema',
            version: '1.0.0',
          ),
        ),
        recipients = const ['did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau'];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive and share a Did document.',
            padding: EdgeInsets.all(5.0),
          ),
          ShareDocumentFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Deriving & sharing...',
              style: TextStyle(color: Colors.white),
            ),
            contentUri: 'https://example.com/document',
            metadata: metadata,
            recipients: recipients,
            child: () => const Text(
              'Derive & Share Did document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ShareDocumentTextField(
                readOnly: true,
                loadingTextCallback: () => 'Deriving & sharing...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class ShareEncDocWidget extends StatelessWidget {
  final sdk.CommercioDocMetadata metadata;
  final List<String> recipients;
  final List<sdk.EncryptedData> encryptedData = [
    sdk.EncryptedData.CONTENT_URI,
    sdk.EncryptedData.METADATA_CONTENT_URI,
    sdk.EncryptedData.METADATA_SCHEMA_URI
  ];

  ShareEncDocWidget()
      : metadata = sdk.CommercioDocMetadata(
          contentUri: 'https://example.com/document/metadata',
          schema: CommercioDocMetadataSchema(
            uri: 'https://example.com/custom/metadata/schema',
            version: '1.0.0',
          ),
        ),
        recipients = const ['did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau'];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive and share an encrypted Did document with a random AES key.',
            padding: EdgeInsets.all(5.0),
          ),
          FutureBuilder<sdk.Key>(
              future: sdk.KeysHelper.generateAesKey(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return FlatButton(
                      onPressed: null,
                      color: Theme.of(context).primaryColor,
                      child: const Text('Derive & Share Did document',
                          style: TextStyle(color: Colors.white)));
                }

                return ShareEncryptedDocumentFlatButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColorDark,
                  loadingChild: () => const Text(
                    'Deriving & sharing...',
                    style: TextStyle(color: Colors.white),
                  ),
                  contentUri: 'https://example.com/document',
                  metadata: metadata,
                  recipients: recipients,
                  aesKey: snap.data,
                  encryptedData: encryptedData,
                  child: () => const Text(
                    'Derive & Share Did document',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ShareEncryptedDocumentTextField(
                readOnly: true,
                loadingTextCallback: () => 'Deriving & sharing...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class SendReceiptWidget extends StatelessWidget {
  final String recipient = 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau';
  final String txHash =
      'BC5810E7A8FD7E057A8EA56152D4C8EF1F38CE235D8DAF179AFD7B75B0415695';
  final String docId = '28cdad1b-9289-4a4a-985e-3a44a1c3ba9b';

  const SendReceiptWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ParagraphWidget(
            'Press the button to send a receipt to hash: $txHash\n\nwith docId: $docId.',
            padding: const EdgeInsets.all(5.0),
          ),
          SendReceiptFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Sending...',
              style: TextStyle(color: Colors.white),
            ),
            recipient: recipient,
            txHash: txHash,
            docId: docId,
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
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class SentDocumentsWidget extends StatelessWidget {
  const SentDocumentsWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the sent documents.',
            padding: EdgeInsets.all(5.0),
          ),
          SentDocumentsFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Sent documents',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SentDocumentsTextField(
                readOnly: true,
                loadingTextCallback: () => 'Loading...',
                textCallback: (state) => state.sentDocuments.fold(
                    '',
                    (prev, curr) =>
                        '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, ')),
          ),
        ],
      ),
    );
  }
}

class ReceivedDocumentsWidget extends StatelessWidget {
  const ReceivedDocumentsWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the received documents.',
            padding: EdgeInsets.all(5.0),
          ),
          ReceivedDocumentsFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Received documents',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ReceivedDocumentsTextField(
                readOnly: true,
                loadingTextCallback: () => 'Loading...',
                textCallback: (state) => state.receivedDocuments.fold(
                    '',
                    (prev, curr) =>
                        '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, ')),
          ),
        ],
      ),
    );
  }
}
