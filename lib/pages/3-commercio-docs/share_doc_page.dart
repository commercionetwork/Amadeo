import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/doc_metadata_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioDocsShareDocumentBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: ShareDocWidget(),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CommercioDocsShareEncryptedDocumentBloc(
                commercioDocs:
                    RepositoryProvider.of<StatefulCommercioDocs>(context),
                commercioId:
                    RepositoryProvider.of<StatefulCommercioId>(context),
              ),
            ),
            BlocProvider(
              create: (_) => CommercioDocsEncDataBloc(),
            )
          ],
          child: const ShareEncDocWidget(),
        ),
      ],
    );
  }
}

class ShareDocWidget extends StatefulWidget {
  @override
  _ShareDocWidgetState createState() => _ShareDocWidgetState();
}

class _ShareDocWidgetState extends State<ShareDocWidget> {
  final _recipientTextController = TextEditingController(
    text: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
  );
  final _contentUriController = TextEditingController(
    text: 'https://example.com/document',
  );
  final _metadataSchemaUriController = TextEditingController(
    text: 'https://example.com/custom/metadata/schema',
  );
  final _metadataSchemaVersionController = TextEditingController(
    text: '1.0.0',
  );
  final _metadataContentUriController = TextEditingController(
    text: 'https://example.com/document/metadata',
  );
  final _metadataSchemaTypeController = TextEditingController(
    text: '',
  );

  @override
  void dispose() {
    _recipientTextController.dispose();
    _contentUriController.dispose();
    _metadataSchemaUriController.dispose();
    _metadataSchemaVersionController.dispose();
    _metadataContentUriController.dispose();
    _metadataSchemaTypeController.dispose();
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
          DocMetadataWidget(
            contentUriController: _contentUriController,
            metadataSchemaUriController: _metadataSchemaUriController,
            metadataSchemaVersionController: _metadataSchemaVersionController,
            metadataContentUriController: _metadataContentUriController,
            metadataSchemaTypeController: _metadataSchemaTypeController,
          ),
          const ParagraphWidget(
            'Press the button to derive and share a Did document.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: ShareDocumentFlatButton(
                event: () => CommercioDocsShareDocumentEvent(
                  recipients: _recipientTextController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                  contentUri: _contentUriController.text,
                  metadata: sdk.CommercioDocMetadata(
                    contentUri: _metadataContentUriController.text,
                    schema: sdk.CommercioDocMetadataSchema(
                      uri: _metadataSchemaUriController.text,
                      version: _metadataSchemaVersionController.text,
                    ),
                    schemaType: _metadataSchemaTypeController.text,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Derive & Share Did document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ShareDocumentTextField(
            loading: (_) => 'Deriving & sharing...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}

class ShareEncDocWidget extends StatefulWidget {
  const ShareEncDocWidget();

  @override
  _ShareEncDocWidgetState createState() => _ShareEncDocWidgetState();
}

class _ShareEncDocWidgetState extends State<ShareEncDocWidget> {
  final _recipientTextController = TextEditingController(
    text: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
  );
  final _contentUriController = TextEditingController(
    text: 'https://example.com/document',
  );
  final _metadataSchemaUriController = TextEditingController(
    text: 'https://example.com/custom/metadata/schema',
  );
  final _metadataSchemaVersionController = TextEditingController(
    text: '1.0.0',
  );
  final _metadataContentUriController = TextEditingController(
    text: 'https://example.com/document/metadata',
  );
  final _metadataSchemaTypeController = TextEditingController(
    text: '',
  );

  @override
  void dispose() {
    _recipientTextController.dispose();
    _contentUriController.dispose();
    _metadataSchemaUriController.dispose();
    _metadataSchemaVersionController.dispose();
    _metadataContentUriController.dispose();
    _metadataSchemaTypeController.dispose();
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
          DocMetadataWidget(
            contentUriController: _contentUriController,
            metadataSchemaUriController: _metadataSchemaUriController,
            metadataSchemaVersionController: _metadataSchemaVersionController,
            metadataContentUriController: _metadataContentUriController,
            metadataSchemaTypeController: _metadataSchemaTypeController,
          ),
          const ParagraphWidget(
            'Press the button to derive and share an encrypted Did document with a random AES key.',
          ),
          ShareDocumentEncryptedDataSwitchListTiles(
            activeColor: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: ShareEncryptedDocumentFlatButton(
                event: () => CommercioDocsShareEncryptedDocumentEvent(
                  recipients: _recipientTextController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                  contentUri: _contentUriController.text,
                  metadata: sdk.CommercioDocMetadata(
                    contentUri: _metadataContentUriController.text,
                    schema: sdk.CommercioDocMetadataSchema(
                      uri: _metadataSchemaUriController.text,
                      version: _metadataSchemaVersionController.text,
                    ),
                    schemaType: _metadataSchemaTypeController.text,
                  ),
                  encryptedData:
                      BlocProvider.of<CommercioDocsEncDataBloc>(context)
                          .encryptedDataList,
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Derive & Share Did document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ShareEncryptedDocumentTextField(
            loading: (_) => 'Deriving & sharing...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
