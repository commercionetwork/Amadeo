import 'package:amadeo/helpers/sdn_data_bloc/sdn_data_bloc.dart';
import 'package:amadeo/helpers/sign_bloc/sign_bloc.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/repositories/document_repository.dart';
import 'package:amadeo/repositories/sdn_selected_repository.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/doc_metadata_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:amadeo/widgets/sdn_data_input_switch_widget.dart';
import 'package:amadeo/widgets/share_signed_doc_input_widget.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class CommercioSignPage extends SectionPageWidget {
  const CommercioSignPage({Key? key})
      : super('/4-sign', 'CommercioSignPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: CommercioSignBody());
  }
}

class CommercioSignBody extends StatelessWidget {
  const CommercioSignBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        GenerateUuidWidget(),
        LoadDocumentWidget(),
        ShareDocDoSignWidget(),
      ],
    );
  }
}

class GenerateUuidWidget extends StatefulWidget {
  const GenerateUuidWidget({Key? key}) : super(key: key);

  @override
  _GenerateUuidWidgetState createState() => _GenerateUuidWidgetState();
}

class _GenerateUuidWidgetState extends State<GenerateUuidWidget> {
  late final SignBloc _signBloc;
  final _uuidTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _signBloc = BlocProvider.of<SignBloc>(context)
      ..add(const SignGenerateNewDocUuid());
  }

  @override
  void dispose() {
    _uuidTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate a new document id',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () => _signBloc.add(const SignGenerateNewDocUuid()),
                child: const Text(
                  'Generate a new document id',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          BlocConsumer<SignBloc, SignState>(
            listener: (context, state) {
              if (state is SignLoadDocumentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (_, state) {
              if (state is SignInitial) {
                _uuidTextController.text = '';
              }

              if (state is NewDocUuid) {
                _uuidTextController.text = state.docId;
              }

              return TextField(
                controller: _uuidTextController,
                readOnly: true,
                maxLines: null,
              );
            },
          ),
        ],
      ),
    );
  }
}

class LoadDocumentWidget extends StatefulWidget {
  const LoadDocumentWidget({Key? key}) : super(key: key);

  @override
  _LoadDocumentWidgetState createState() => _LoadDocumentWidgetState();
}

class _LoadDocumentWidgetState extends State<LoadDocumentWidget> {
  late final DocumentRepository _documentRepository;

  @override
  void initState() {
    super.initState();

    _documentRepository = RepositoryProvider.of<DocumentRepository>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state is SignLoadDocumentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: FutureBuilder<String>(
        future: _documentRepository.fetchContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Card(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                ParagraphWidget(
                  'The document that will be sended is: \n\n${_documentRepository.documentPath}\n\n with the following content:\n\n${snapshot.data}',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ShareDocDoSignWidget extends StatefulWidget {
  const ShareDocDoSignWidget({Key? key}) : super(key: key);

  @override
  _ShareDocDoSignWidgetState createState() => _ShareDocDoSignWidgetState();
}

class _ShareDocDoSignWidgetState extends State<ShareDocDoSignWidget> {
  late final SignBloc _signBloc;
  late final StatefulCommercioAccount _commercioAccount;
  final _recipientTextController = TextEditingController(
    text: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
  );
  final _signerIstanceTextController = TextEditingController();
  final _storageUriTextController = TextEditingController();
  final _vcrIdTextController = TextEditingController(text: 'xxxx');
  final _certificateProfileTextController = TextEditingController(text: 'xxxx');
  final _contentUriController = TextEditingController(
    text: 'https://example.com/document',
  );
  final _metadataSchemaUriController = TextEditingController(
    text: 'https://example.com/custom/metadata/schema',
  );
  final _metadataSchemaVersionController = TextEditingController(text: '1.0.0');
  final _metadataContentUriController = TextEditingController(
    text: 'https://example.com/document/metadata',
  );
  final _metadataSchemaTypeController = TextEditingController(text: '');
  final _signedTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _signBloc = BlocProvider.of<SignBloc>(context);
    _commercioAccount =
        RepositoryProvider.of<StatefulCommercioAccount>(context);

    _storageUriTextController.text =
        Uri.http('${_signBloc.dsbUrl}:${_signBloc.dsbPort}', '').toString();
    _signerIstanceTextController.text = _signBloc.dsbSignerAddress;
  }

  @override
  void dispose() {
    _recipientTextController.dispose();
    _signerIstanceTextController.dispose();
    _storageUriTextController.dispose();
    _vcrIdTextController.dispose();
    _certificateProfileTextController.dispose();
    _contentUriController.dispose();
    _metadataSchemaUriController.dispose();
    _metadataSchemaVersionController.dispose();
    _metadataContentUriController.dispose();
    _metadataSchemaTypeController.dispose();
    _signedTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sdnSelectedDataRepository =
        RepositoryProvider.of<SdnSelectedDataRepository>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocConsumer<SignBloc, SignState>(
        listener: (context, state) {
          if (state is SignDocumentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SignedDocument) {
            _signedTextController.text = state.result;
          } else {
            _signedTextController.text = '';
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipientAddressTextFieldWidget(
                recipientTextController: _recipientTextController,
              ),
              DocMetadataWidget(
                contentUriController: _contentUriController,
                metadataSchemaUriController: _metadataSchemaUriController,
                metadataSchemaVersionController:
                    _metadataSchemaVersionController,
                metadataContentUriController: _metadataContentUriController,
                metadataSchemaTypeController: _metadataSchemaTypeController,
              ),
              ShareSignedDocInputWidget(
                signerIstanceTextController: _signerIstanceTextController,
                storageUriTextController: _storageUriTextController,
                vcrIdTextController: _vcrIdTextController,
                certificateProfileTextController:
                    _certificateProfileTextController,
              ),
              const ParagraphWidget(
                'Select the Subject Distinguish Names to include in the generated certificate.',
              ),
              BlocProvider(
                create: (_) => SdnDataBloc(
                  sdnSelectedDataRepository: sdnSelectedDataRepository,
                ),
                child: SdnDataInputSwitchWidget(
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
              const ParagraphWidget(
                'Press the button to derive and share a Did document with signature.',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: (state is SignDocumentLoading)
                        ? null
                        : () => _signBloc.add(SignDocumentEvent(
                              recipients: _recipientTextController.text
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList(),
                              docId: RepositoryProvider.of<DocumentRepository>(
                                      context)
                                  .docId,
                              signerIstance: _signerIstanceTextController.text,
                              storageUri: _storageUriTextController.text,
                              sdnData: RepositoryProvider.of<
                                      SdnSelectedDataRepository>(context)
                                  .sdnDataSet,
                              vcrId: _vcrIdTextController.text,
                              certificateProfile:
                                  _certificateProfileTextController.text,
                              contentUri: _contentUriController.text,
                              metadata: sdk.CommercioDocMetadata(
                                contentUri: _metadataContentUriController.text,
                                schema: sdk.CommercioDocMetadataSchema(
                                  uri: _metadataSchemaUriController.text,
                                  version:
                                      _metadataSchemaVersionController.text,
                                ),
                                schemaType: _metadataSchemaTypeController.text,
                              ),
                              walletAddress: _commercioAccount.walletAddress!,
                            )),
                    child: const Text(
                      'Sign document',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _signedTextController,
                readOnly: true,
                maxLines: null,
              )
            ],
          );
        },
      ),
    );
  }
}
