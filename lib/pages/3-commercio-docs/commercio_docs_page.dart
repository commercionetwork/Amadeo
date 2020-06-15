import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioDocsPage extends SectionPageWidget {
  const CommercioDocsPage({Key key})
      : super('/3-docs', 'CommercioDocsPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: CommercioDocsBody());
  }
}

class CommercioDocsBody extends StatelessWidget {
  const CommercioDocsBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/3-docs/share-doc'),
                  child: const Text(
                    '3.1 shareDoc(1->1. 1->n, plain/encrypted)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/3-docs/send-receipt'),
                  child: const Text(
                    '3.2 sendReceipt(1->1)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/3-docs/document-list'),
                  child: const Text(
                    '3.3 documentList(sent/received)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/3-docs/receipt-list'),
                  child: const Text(
                    '3.4 receiptList(sent/received)',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
