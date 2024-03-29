import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/commercio_doc_presenter.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/doc_metadata_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class ShareDocPage extends SectionPageWidget {
  const ShareDocPage({Key? key})
      : super('/3-docs/share-doc', 'ShareDocPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioDocsDeriveDocumentBloc(
          commercioDocs: context.read<StatefulCommercioDocs>(),
          commercioId: context.read<StatefulCommercioId>(),
        ),
        child: const ShareDocPageBody(),
      ),
    );
  }
}

class ShareDocPageBody extends StatelessWidget {
  const ShareDocPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioDocsEncDataBloc(),
          child: const DeriveDocWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioDocsShareDocumentsBloc(
            commercioDocs: context.read<StatefulCommercioDocs>(),
            commercioId: context.read<StatefulCommercioId>(),
          ),
          child: const ShareDocsWidget(),
        ),
      ],
    );
  }
}

class DeriveDocWidget extends StatefulWidget {
  const DeriveDocWidget({Key? key}) : super(key: key);

  @override
  _DeriveDocWidgetState createState() => _DeriveDocWidgetState();
}

class _DeriveDocWidgetState extends State<DeriveDocWidget> {
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
          ShareDocumentEncryptedDataSwitchListTiles(
            style: CommercioSwitchListTileStyle(
              activeColor: Theme.of(context).primaryColor,
            ),
          ),
          const ParagraphWidget(
            'Press the button to derive a Did document.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: DeriveDocumentFlatButton(
                event: () => CommercioDocsDeriveDocumentEvent(
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
                      context.read<CommercioDocsEncDataBloc>().encryptedDataSet,
                ),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Derive a Did document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          DeriveDocumentTextField(
            loading: (_) => 'Deriving...',
            text: (_, state) => state.maybeWhen(
              (commercioDoc) => commercioDocToString(commercioDoc),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class ShareDocsWidget extends StatelessWidget {
  const ShareDocsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to share the previously generated Did document.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: BlocBuilder<CommercioDocsDeriveDocumentBloc,
                  CommercioDocsDeriveDocumentState>(
                builder: (context, state) {
                  final fn = (state is CommercioDocsDeriveDocumentStateData)
                      ? () => CommercioDocsShareDocumentsEvent(
                            commercioDocs: [state.commercioDoc],
                          )
                      : null;

                  return ShareDocumentsFlatButton(
                    event: fn,
                    buttonStyle: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: (_) => const Text(
                      'Share Did document',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          ShareDocumentsTextField(
            loading: (_) => 'Sharing...',
            text: (_, state) => state.maybeWhen(
              (result) => txResultToString(result),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
