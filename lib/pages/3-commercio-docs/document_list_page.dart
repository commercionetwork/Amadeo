import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentListPage extends SectionPageWidget {
  const DocumentListPage({Key key})
      : super('/3-docs/document-list', 'DocumentListPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: DocumentListPageBody(),
    );
  }
}

class DocumentListPageBody extends StatelessWidget {
  const DocumentListPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioDocsSentDocumentsBloc>(
                  create: (_) => CommercioDocsSentDocumentsBloc(
                    commercioDocs:
                        RepositoryProvider.of<StatefulCommercioDocs>(context),
                    commercioId:
                        RepositoryProvider.of<StatefulCommercioId>(context),
                  ),
                  child: const SentDocumentsWidget(),
                ),
                BlocProvider<CommercioDocsReceivedDocumentsBloc>(
                  create: (_) => CommercioDocsReceivedDocumentsBloc(
                    commercioDocs:
                        RepositoryProvider.of<StatefulCommercioDocs>(context),
                    commercioId:
                        RepositoryProvider.of<StatefulCommercioId>(context),
                  ),
                  child: const ReceivedDocumentsWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
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
            accountEventCallback: () => const CommercioDocsSentDocumentsEvent(),
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
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
              maxLines: null,
            ),
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
            accountEventCallback: () =>
                const CommercioDocsReceivedDocumentsEvent(),
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
                      '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
