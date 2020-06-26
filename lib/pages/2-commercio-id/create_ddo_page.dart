import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
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
                  child: const GenerateKeysWidget(),
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
            accountEventCallback: () => const CommercioIdGenerateKeysEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Generating...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Generate keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GenerateKeysTextField(
              readOnly: true,
              loadingTextCallback: () => 'Generating...',
              textCallback: (state) => jsonEncode(state.commercioIdKeys),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
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
            accountEventCallback: () =>
                const CommercioIdDeriveDidDocumentEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Deriving...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Derive document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DeriveDidDocumentTextField(
              readOnly: true,
              loadingTextCallback: () => 'Deriving...',
              textCallback: (state) => jsonEncode(state.didDocument),
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
            accountEventCallback: () => const CommercioIdSetDidDocumentEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Setting...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Set document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SetDidDocumentTextField(
              readOnly: true,
              loadingTextCallback: () => 'Setting...',
              textCallback: (state) => state.result.success
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
            accountEventCallback: () => const CommercioIdRestoreKeysEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Restoring...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Restore keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreKeysTextField(
              readOnly: true,
              loadingTextCallback: () => 'Restoring...',
              textCallback: (state) => jsonEncode(state.commercioIdKeys),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
