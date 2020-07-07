import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
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
              ? const GenerateKeysWebWidget()
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
          create: (_) => CommercioIdSetDidDocumentBloc(
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
  const GenerateKeysWidget();

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
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Generate keys',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          GenerateKeysTextField(
            loading: (_) => 'Generating...',
            text: (_, state) => jsonEncode(state.commercioIdKeys),
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
  final String _demoKeysPath = 'assets/id_keys.json';
  final _textController = TextEditingController(text: '');
  bool _isFetchingDemoKeys = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<String> _fetchDemoKeys() async {
    final rsaKeysRaw = await rootBundle.loadString(_demoKeysPath);
    final decodedJson = jsonDecode(rsaKeysRaw) as Map<String, dynamic>;
    RepositoryProvider.of<StatefulCommercioId>(context).commercioIdKeys =
        CommercioIdKeys.fromJson(decodedJson);

    return rsaKeysRaw;
  }

  void _showWebKeysWarningDialog() {
    if (_textController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text(
              'Web support is highly experimental, demo key pairs are given.\n\nDO NOT USE THESE KEYS OUTSIDE THIS DEMO!',
            ),
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
        _textController.text = '';
        _isFetchingDemoKeys = true;
      });
    };

    return FutureBuilder<String>(
        future: _isFetchingDemoKeys ? _fetchDemoKeys() : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            onPressed = null;
          }

          if (snapshot.connectionState == ConnectionState.done) {
            _textController.text = snapshot.data;
          }

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
                    child: FlatButton(
                      onPressed: onPressed,
                      color: Theme.of(context).primaryColor,
                      disabledColor: Theme.of(context).primaryColorDark,
                      child: const Text(
                        'Generate keys',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                TextField(
                  readOnly: true,
                  maxLines: null,
                  controller: _textController,
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
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Derive document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          DeriveDidDocumentTextField(
            loading: (_) => 'Deriving...',
            text: (_, state) => jsonEncode(state.didDocument),
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
                event: () => const CommercioIdSetDidDocumentEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Set document',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SetDidDocumentTextField(
            loading: (_) => 'Setting...',
            text: (_, state) => txResultToString(state.result),
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
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Restore keys',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RestoreKeysTextField(
            loading: (_) => 'Restoring...',
            text: (_, state) => jsonEncode(state.commercioIdKeys),
          ),
        ],
      ),
    );
  }
}
