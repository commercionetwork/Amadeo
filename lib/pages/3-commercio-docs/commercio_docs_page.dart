import 'package:amadeo/pages/export.dart';
import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioDocsPage extends SectionPageWidget {
  const CommercioDocsPage({Key? key})
      : super('/3-docs', 'CommercioDocsPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: CommercioDocsBody());
  }
}

class CommercioDocsBody extends StatelessWidget {
  const CommercioDocsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseListWidget(
      children: [
        SubSectionWidget(
          sectionPage: ShareDocPage(),
          title: '3.1 shareDoc(1->1. 1->n, plain/encrypted)',
          subtitle:
              'Creates a new transaction that allows to share the document associated with the given contentUri and having the given metadata and checksum. If encryptedData is specified, encrypts the proper data.',
        ),
        SubSectionWidget(
          sectionPage: SendReceiptPage(),
          title: '3.2 sendReceipt(1->1)',
          subtitle:
              'Creates a new transaction which tells the recipient that the document having the specified documentId and present inside the transaction with hash txHash has been properly seen.',
        ),
        SubSectionWidget(
          sectionPage: DocumentListPage(),
          title: '3.3 documentList(sent/received)',
          subtitle:
              "Get the document's list sent and received from an acccount.",
        ),
        SubSectionWidget(
          sectionPage: ReceiptListPage(),
          title: '3.4 receiptList(sent/received)',
          subtitle:
              "Get the receipt's list sent and received from an acccount.",
        ),
      ],
    );
  }
}
