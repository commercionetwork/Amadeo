import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/doc_metadata_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareDocPage extends SectionPageWidget {
  const ShareDocPage({Key key})
      : super('/3-docs/share-doc', 'ShareDocPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: ShareDocPageBody(),
    );
  }
}

class ShareDocPageBody extends StatelessWidget {
  const ShareDocPageBody();

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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShareDocWidget extends StatelessWidget {
  final TextEditingController recipientsController = TextEditingController();
  final TextEditingController contentUriController = TextEditingController();
  final TextEditingController metadataSchemaUriController =
      TextEditingController();
  final TextEditingController metadataSchemaVersionController =
      TextEditingController();
  final TextEditingController metadataContentUriController =
      TextEditingController();
  final TextEditingController metadataSchemaTypeController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                hintText: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau,',
                labelText: 'Recipient addresses (comma separated)'),
            controller: recipientsController,
          ),
          DocMetadataWidget(
            contentUriController: contentUriController,
            metadataSchemaUriController: metadataSchemaUriController,
            metadataSchemaVersionController: metadataSchemaVersionController,
            metadataContentUriController: metadataContentUriController,
            metadataSchemaTypeController: metadataSchemaTypeController,
          ),
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
            contentUri: contentUriController.text,
            metadata: sdk.CommercioDocMetadata(
              contentUri: metadataContentUriController.text,
              schema: sdk.CommercioDocMetadataSchema(
                uri: metadataContentUriController.text,
                version: metadataSchemaVersionController.text,
              ),
              schemaType: metadataSchemaTypeController.text,
            ),
            recipients: recipientsController.text
                .split(',')
                .map((e) => e.trim())
                .toList(),
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
  final TextEditingController recipientsController = TextEditingController();
  final TextEditingController contentUriController = TextEditingController();
  final TextEditingController metadataSchemaUriController =
      TextEditingController();
  final TextEditingController metadataSchemaVersionController =
      TextEditingController();
  final TextEditingController metadataContentUriController =
      TextEditingController();
  final TextEditingController metadataSchemaTypeController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
                hintText: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau,',
                labelText: 'Recipient addresses (comma separated)'),
            controller: recipientsController,
          ),
          DocMetadataWidget(
            contentUriController: contentUriController,
            metadataSchemaUriController: metadataSchemaUriController,
            metadataSchemaVersionController: metadataSchemaVersionController,
            metadataContentUriController: metadataContentUriController,
            metadataSchemaTypeController: metadataSchemaTypeController,
          ),
          const ParagraphWidget(
            'Press the button to derive and share an encrypted Did document with a random AES key.',
            padding: EdgeInsets.all(5.0),
          ),
          ShareDocumentEncryptedDataSwitchListTiles(
            activeColor: Theme.of(context).primaryColor,
          ),
          ShareEncryptedDocumentFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Deriving & sharing...',
              style: TextStyle(color: Colors.white),
            ),
            contentUri: contentUriController.text,
            metadata: sdk.CommercioDocMetadata(
              contentUri: metadataContentUriController.text,
              schema: sdk.CommercioDocMetadataSchema(
                uri: metadataContentUriController.text,
                version: metadataSchemaVersionController.text,
              ),
              schemaType: metadataSchemaTypeController.text,
            ),
            recipients: recipientsController.text
                .split(',')
                .map((e) => e.trim())
                .toList(),
            encryptedData: () =>
                BlocProvider.of<CommercioDocsEncDataBloc>(context)
                    .encryptedDataList,
            child: () => const Text(
              'Derive & Share Did document',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
