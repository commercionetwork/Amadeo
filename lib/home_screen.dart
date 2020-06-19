import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amadeo/entities/section_page.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/section_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  final List<SectionPage> sections = const [
    SectionPage(
        sectionPageWidget: CommercioAccountPage(),
        title: 'Commercio Account',
        description:
            'Electronically Sign any PDF e XML digital document so no-one can deny having digitally signed the document'),
    SectionPage(
      sectionPageWidget: CommercioIdPage(),
      title: 'Commercio Id',
      description:
          'Grasp the self sovereign identity and pairwise user connections',
    ),
    SectionPage(
      sectionPageWidget: CommercioDocsPage(),
      title: 'Commercio Docs',
      description:
          'Send a document and prove its paternity, non repudial and integrity',
    ),
    SectionPage(
      sectionPageWidget: CommercioSignPage(),
      title: 'Commercio Sign',
    ),
    SectionPage(
      sectionPageWidget: CommercioMintPage(),
      title: 'Commercio Mint',
      description:
          'Mint and Burn 1€ a stable coin called Commercio Cash Credit CCC that can be used to pay trasaction fees',
    ),
    SectionPage(
      sectionPageWidget: CommercioKYCPage(),
      title: 'Commercio KYC',
      description:
          'Create a network of trusted organizations by inviting companies to perform KYC and earn ABR token rewards ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: SingleChildScrollView(
        child: Column(
          children: sections
              .map((section) => SectionCardWidget(sectionPage: section))
              .toList(),
        ),
      ),
    );
  }
}
