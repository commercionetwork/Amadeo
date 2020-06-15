import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

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
              children: const [
                SentDocumentsWidget(),
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
                        '$prev ${prev.isEmpty ? '' : '\n\n'} ${jsonEncode(curr)}, ')),
          ),
        ],
      ),
    );
  }
}
