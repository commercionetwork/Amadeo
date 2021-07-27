import 'package:amadeo/helpers/demo_keys/demo_keys_bloc.dart';
import 'package:amadeo/helpers/warning_dialog_bloc/warning_dialog_bloc.dart';
import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/commercio_keys_presenter.dart';
import 'package:amadeo/presenters/did_doc_presenter.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/repositories/dialog_warnings_repository.dart';
import 'package:amadeo/repositories/keys_repository.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class CreateDDOPage extends SectionPageWidget {
  const CreateDDOPage({Key? key})
      : super('/2-id/create-ddo', 'CreateDDOPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: CreateDDOPageBody(),
    );
  }
}

class CreateDDOPageBody extends StatelessWidget {
  const CreateDDOPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioIdGenerateKeysBloc(
            commercioId: RepositoryProvider.of<StatefulCommercioId>(
              context,
            ),
          ),
          child: kIsWeb
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => WarningDialogBloc(
                        dialogWarningsRepository:
                            RepositoryProvider.of<DialogWarningsRepository>(
                          context,
                        ),
                      ),
                    ),
                    BlocProvider(
                      create: (_) => DemoKeysBloc(
                        keysRepository:
                            RepositoryProvider.of<KeysRepository>(context),
                        commercioIdKeys:
                            RepositoryProvider.of<StatefulCommercioId>(context),
                      ),
                    ),
                  ],
                  child: const GenerateKeysWebWidget(),
                )
              : const GenerateKeysWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioIdDeriveDidDocumentBloc(
            commercioId: RepositoryProvider.of<StatefulCommercioId>(
              context,
            ),
          ),
          child: const DeriveDidDocumentWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioIdSetDidDocumentsBloc(
            commercioId: RepositoryProvider.of<StatefulCommercioId>(
              context,
            ),
          ),
          child: const SetDidDocumentWidget(),
        ),
      ],
    );
  }
}

class GenerateKeysWidget extends StatelessWidget {
  const GenerateKeysWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to generate new RSA keys.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: GenerateKeysFlatButton(
                event: () => const CommercioIdGenerateKeysEvent(),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Generate keys',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GenerateKeysTextField(
            loading: (_) => 'Generating...',
            text: (_, state) => state.maybeWhen(
              (commercioIdKeys) => commercioKeysToString(commercioIdKeys),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class GenerateKeysWebWidget extends StatefulWidget {
  const GenerateKeysWebWidget({Key? key}) : super(key: key);

  @override
  _GenerateKeysWebWidgetState createState() => _GenerateKeysWebWidgetState();
}

class _GenerateKeysWebWidgetState extends State<GenerateKeysWebWidget> {
  final _textController = TextEditingController(text: '');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showWebKeysWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            'Web support is highly experimental, demo key pairs are given.\n\nDO NOT USE THESE KEYS OUTSIDE THIS DEMO!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WarningDialogBloc, WarningDialogState>(
      listener: (context, state) {
        if (state is ShowKeysWarningDialogState) {
          _showWebKeysWarningDialog(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ParagraphWidget(
              'Press the button to generate new RSA keys.',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    BlocProvider.of<WarningDialogBloc>(context).add(
                      const MaybeShowKeysWarningDialogEvent(),
                    );

                    BlocProvider.of<DemoKeysBloc>(context).add(
                      const LoadDemoKeysEvent(),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    'Generate keys',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            BlocConsumer<DemoKeysBloc, DemoKeysState>(
              listener: (context, state) {
                if (state is DemoKeysError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DemoKeysLoading) {
                  _textController.text = 'Loading...';
                }

                if (state is DemoKeysError) {
                  _textController.text = state.message;
                }

                if (state is DemoKeysData) {
                  _textController.text =
                      commercioKeysToString(state.commercioIdKeys);
                }

                return TextField(
                  readOnly: true,
                  maxLines: null,
                  controller: _textController,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeriveDidDocumentWidget extends StatelessWidget {
  const DeriveDidDocumentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget('Press the button to derive a Did document.'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: DeriveDidDocumentFlatButton(
                event: () => const CommercioIdDeriveDidDocumentEvent(),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Derive document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          DeriveDidDocumentTextField(
            loading: (_) => 'Deriving...',
            text: (_, state) => state.maybeWhen(
              (didDocument) => didDocumentToString(didDocument),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class SetDidDocumentWidget extends StatelessWidget {
  const SetDidDocumentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to derive and set a Did document.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: SetDidDocumentFlatButton(
                event: () => const CommercioIdSetDidDocumentsEvent(),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Set document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SetDidDocumentTextField(
            loading: (_) => 'Setting...',
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

class RestoreKeysWidget extends StatelessWidget {
  const RestoreKeysWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget('Press the button to restore the RSA keys.'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: RestoreKeysFlatButton(
                event: () => const CommercioIdRestoreKeysEvent(),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Restore keys',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RestoreKeysTextField(
            loading: (_) => 'Restoring...',
            text: (_, state) => state.maybeWhen(
              (commercioIdKeys) => commercioKeysToString(commercioIdKeys),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
