import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/subsection_widget.dart';
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
              children: const [
                SubSectionWidget(
                  sectionPage: ShareDocPage(),
                  title: '3.1 shareDoc(1->1. 1->n, plain/encrypted)',
                ),
                SubSectionWidget(
                  sectionPage: SendReceiptPage(),
                  title: '3.2 sendReceipt(1->1)',
                ),
                SubSectionWidget(
                  sectionPage: DocumentListPage(),
                  title: '3.3 documentList(sent/received)',
                ),
                SubSectionWidget(
                  sectionPage: ReceiptListPage(),
                  title: '3.4 receiptList(sent/received)',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
