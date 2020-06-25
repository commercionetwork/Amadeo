import 'package:amadeo/helpers/sign_bloc/sign_bloc.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/repositories/document_repository.dart';
import 'package:amadeo/repositories/sdn_selected_repository.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/doc_metadata_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:amadeo/widgets/sdn_data_input_switch_widget.dart';
import 'package:amadeo/widgets/share_signed_doc_input_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommercioSignPage extends SectionPageWidget {
  const CommercioSignPage({Key key})
      : super('/4-sign', 'CommercioSignPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(bodyWidget: CommercioSignBody());
  }
}

class CommercioSignBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                GenerateUuidWidget(),
                LoadDocumentWidget(),
                ShareDocDoSignWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenerateUuidWidget extends StatelessWidget {
  GenerateUuidWidget();

  final TextEditingController uuidTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signBloc = BlocProvider.of<SignBloc>(context);

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              const ParagraphWidget(
                'Press the button to generate a new document id',
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => signBloc.add(const SignGenerateNewDocUuid()),
                child: const Text(
                  'Generate new document id',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BlocConsumer<SignBloc, SignState>(
                listener: (context, state) {
                  if (state is SignLoadDocumentError) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (_, state) {
                  if (state is SignInitial) {
                    uuidTextController.text = '';
                  }

                  if (state is NewDocUuid) {
                    uuidTextController.text = state.docId;
                  }

                  return TextField(
                    controller: uuidTextController,
                    readOnly: true,
                  );
                },
              ),
            ],
          )),
    );
  }
}

class LoadDocumentWidget extends StatelessWidget {
  final TextEditingController documentTextController =
      TextEditingController(text: '');

  LoadDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignBloc, SignState>(
      listener: (context, state) {
        if (state is SignLoadDocumentError) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              const ParagraphWidget(
                'Press the button to load the content of a generic document',
              ),
              BlocBuilder<SignBloc, SignState>(
                builder: (context, state) {
                  return FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (state is SignLoadDocumentLoading)
                          ? null
                          : () => BlocProvider.of<SignBloc>(context)
                              .add(const SignLoadDocumentEvent()),
                      child: const Text(
                        'Load document',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ));
                },
              ),
              BlocBuilder<SignBloc, SignState>(
                builder: (context, state) {
                  if (state is SignDocumentLoaded) {
                    documentTextController.text = state.content;
                  }

                  if (state is SignLoadDocumentError) {
                    documentTextController.text = state.error;
                  }

                  return TextField(
                    controller: documentTextController,
                    readOnly: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareDocDoSignWidget extends StatefulWidget {
  @override
  _ShareDocDoSignWidgetState createState() => _ShareDocDoSignWidgetState();
}

class _ShareDocDoSignWidgetState extends State<ShareDocDoSignWidget> {
  final TextEditingController recipientTextController = TextEditingController();
  final TextEditingController signerIstanceTextController =
      TextEditingController();
  final TextEditingController storageUriTextController =
      TextEditingController();
  final TextEditingController vcrIdTextController =
      TextEditingController(text: 'xxxx');
  final TextEditingController certificateProfileTextController =
      TextEditingController(text: 'xxxx');
  final TextEditingController contentUriController = TextEditingController();
  final TextEditingController metadataSchemaUriController =
      TextEditingController();
  final TextEditingController metadataSchemaVersionController =
      TextEditingController();
  final TextEditingController metadataContentUriController =
      TextEditingController();
  final TextEditingController metadataSchemaTypeController =
      TextEditingController(text: '');
  final TextEditingController signedTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signBloc = BlocProvider.of<SignBloc>(context);
    final commercioAccount =
        RepositoryProvider.of<StatefulCommercioAccount>(context);

    storageUriTextController.text =
        Uri.http('${signBloc.dsbUrl}:${signBloc.dsbPort}', '').toString();
    signerIstanceTextController.text = signBloc.dsbSignerAddress;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: BlocConsumer<SignBloc, SignState>(listener: (context, state) {
          if (state is SignDocumentError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        }, builder: (context, state) {
          if (state is SignedDocument) {
            signedTextController.text = state.result;
          } else {
            signedTextController.text = '';
          }

          return Column(
            children: [
              RecipientAddressTextFieldWidget(
                recipientTextController: recipientTextController,
              ),
              DocMetadataWidget(
                contentUriController: contentUriController,
                metadataSchemaUriController: metadataSchemaUriController,
                metadataSchemaVersionController:
                    metadataSchemaVersionController,
                metadataContentUriController: metadataContentUriController,
                metadataSchemaTypeController: metadataSchemaTypeController,
              ),
              ShareSignedDocInputWidget(
                signerIstanceTextController: signerIstanceTextController,
                storageUriTextController: storageUriTextController,
                vcrIdTextController: vcrIdTextController,
                certificateProfileTextController:
                    certificateProfileTextController,
              ),
              const ParagraphWidget(
                'Select the Subject Distinguish Names to include in the generated certificate.',
              ),
              SdnDataInputSwitchWidget(
                activeColor: Theme.of(context).primaryColor,
              ),
              const ParagraphWidget(
                'Press the button to derive and share a Did document with signature.',
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: (state is SignDocumentLoading)
                    ? null
                    : () => signBloc.add(SignDocumentEvent(
                          recipients: recipientTextController.text
                              .split(',')
                              .map((e) => e.trim())
                              .toList(),
                          docId:
                              RepositoryProvider.of<DocumentRepository>(context)
                                  .docId,
                          signerIstance: signerIstanceTextController.text,
                          storageUri: storageUriTextController.text,
                          sdnData:
                              RepositoryProvider.of<SdnSelectedDataRepository>(
                                      context)
                                  .sdnDataList,
                          vcrId: vcrIdTextController.text,
                          certificateProfile:
                              certificateProfileTextController.text,
                          contentUri: contentUriController.text,
                          metadata: sdk.CommercioDocMetadata(
                            contentUri: metadataContentUriController.text,
                            schema: sdk.CommercioDocMetadataSchema(
                              uri: metadataSchemaUriController.text,
                              version: metadataSchemaVersionController.text,
                            ),
                            schemaType: metadataSchemaTypeController.text,
                          ),
                          walletAddress: commercioAccount.walletAddress,
                        )),
                child: const Text(
                  'Sign document',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextField(
                controller: signedTextController,
                readOnly: true,
              )
            ],
          );
        }),
      ),
    );
  }
}
