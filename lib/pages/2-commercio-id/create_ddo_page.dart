import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDDOPage extends SectionPageWidget {
  const CreateDDOPage({Key key})
      : super('/2-id/create-ddo', 'CreateDDOPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: CreateDDOPageBody(),
    );
  }
}

class CreateDDOPageBody extends StatelessWidget {
  const CreateDDOPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioIdGenerateKeysBloc>(
                  create: (_) => CommercioIdGenerateKeysBloc(
                    commercioId: RepositoryProvider.of<StatefulCommercioId>(
                      context,
                    ),
                  ),
                  child: kIsWeb
                      ? const GenerateKeysWebWidget()
                      : const GenerateKeysWidget(),
                ),
                BlocProvider<CommercioIdDeriveDidDocumentBloc>(
                  create: (_) => CommercioIdDeriveDidDocumentBloc(
                    commercioId: RepositoryProvider.of<StatefulCommercioId>(
                      context,
                    ),
                  ),
                  child: const DeriveDidDocumentWidget(),
                ),
                BlocProvider<CommercioIdSetDidDocumentBloc>(
                  create: (_) => CommercioIdSetDidDocumentBloc(
                    commercioId: RepositoryProvider.of<StatefulCommercioId>(
                      context,
                    ),
                  ),
                  child: const SetDidDocumentWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenerateKeysWidget extends StatelessWidget {
  const GenerateKeysWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate new RSA keys.',
            padding: EdgeInsets.all(5.0),
          ),
          GenerateKeysFlatButton(
            event: () => const CommercioIdGenerateKeysEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Generating...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Generate keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GenerateKeysTextField(
              readOnly: true,
              loading: (_) => 'Generating...',
              text: (_, state) => jsonEncode(state.commercioIdKeys),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

class GenerateKeysWebWidget extends StatefulWidget {
  const GenerateKeysWebWidget();

  @override
  _GenerateKeysWebWidgetState createState() => _GenerateKeysWebWidgetState();
}

class _GenerateKeysWebWidgetState extends State<GenerateKeysWebWidget> {
  final String demoKeysPath = 'assets/id_keys.json';
  final textController = TextEditingController(text: '');
  bool isFetchingDemoKeys = false;

  Future<String> _fetchDemoKeys() async {
    final rsaKeysRaw = await rootBundle.loadString(demoKeysPath);
    final decodedJson = jsonDecode(rsaKeysRaw) as Map<String, dynamic>;
    RepositoryProvider.of<StatefulCommercioId>(context).commercioIdKeys =
        CommercioIdKeys.fromJson(decodedJson);

    return rsaKeysRaw;
  }

  void _showWebKeysWarningDialog() {
    if (textController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'Web support is highly experimental, demo key pairs are given.\n\nDO NOT USE THESE KEYS OUTSIDE THIS DEMO!'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void Function() onPressed = () {
      _showWebKeysWarningDialog();

      setState(() {
        textController.text = '';
        isFetchingDemoKeys = true;
      });
    };

    return FutureBuilder<String>(
        future: isFetchingDemoKeys ? _fetchDemoKeys() : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            onPressed = null;
          }

          if (snapshot.connectionState == ConnectionState.done) {
            textController.text = snapshot.data;
          }

          return Card(
            child: Column(
              children: [
                const ParagraphWidget(
                  'Press the button to generate new RSA keys.',
                  padding: EdgeInsets.all(5.0),
                ),
                FlatButton(
                  onPressed: onPressed,
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColorDark,
                  child: const Text(
                    'Generate keys',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    readOnly: true,
                    maxLines: null,
                    controller: textController,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class DeriveDidDocumentWidget extends StatelessWidget {
  const DeriveDidDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive a Did document.',
            padding: EdgeInsets.all(5.0),
          ),
          DeriveDidDocumentFlatButton(
            event: () => const CommercioIdDeriveDidDocumentEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Deriving...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Derive document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DeriveDidDocumentTextField(
              readOnly: true,
              loading: (_) => 'Deriving...',
              text: (_, state) => jsonEncode(state.didDocument),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

class SetDidDocumentWidget extends StatelessWidget {
  const SetDidDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive and set a Did document.',
            padding: EdgeInsets.all(5.0),
          ),
          SetDidDocumentFlatButton(
            event: () => const CommercioIdSetDidDocumentEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Setting...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Set document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SetDidDocumentTextField(
              readOnly: true,
              loading: (_) => 'Setting...',
              text: (_, state) => state.result.success
                  ? 'Success! Hash: ${state.result.hash}'
                  : 'Error: ${jsonEncode(state.result.error)}',
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}

class RestoreKeysWidget extends StatelessWidget {
  const RestoreKeysWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to restore the RSA keys.',
            padding: EdgeInsets.all(5.0),
          ),
          RestoreKeysFlatButton(
            event: () => const CommercioIdRestoreKeysEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Restoring...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Restore keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreKeysTextField(
              readOnly: true,
              loading: (_) => 'Restoring...',
              text: (_, state) => jsonEncode(state.commercioIdKeys),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
