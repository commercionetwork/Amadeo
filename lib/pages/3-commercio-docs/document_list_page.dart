import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioDocsSentDocumentsBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: const SentDocumentsWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioDocsReceivedDocumentsBloc(
            commercioDocs:
                RepositoryProvider.of<StatefulCommercioDocs>(context),
            commercioId: RepositoryProvider.of<StatefulCommercioId>(context),
          ),
          child: const ReceivedDocumentsWidget(),
        ),
      ],
    );
  }
}

class SentDocumentsWidget extends StatelessWidget {
  const SentDocumentsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the sent documents.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: SentDocumentsFlatButton(
                event: () => const CommercioDocsSentDocumentsEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Sent documents',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SentDocumentsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.sentDocuments.fold(
                '',
                (prev, curr) =>
                    '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to get a list of the received documents.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: ReceivedDocumentsFlatButton(
                event: () => const CommercioDocsReceivedDocumentsEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Received documents',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          ReceivedDocumentsTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.receivedDocuments.fold(
                '',
                (prev, curr) =>
                    '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, '),
          ),
        ],
      ),
    );
  }
}
