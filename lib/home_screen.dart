import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:amadeo/entities/section_page.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/section_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool alertDisplayed = false;

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
        description:
            'Electronically sign any PDF and XML digital document so no-one can deny having digitally signed the document'),
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

  void _showWebWarningDialog() {
    if (kIsWeb && !alertDisplayed) {
      setState(() {
        alertDisplayed = true;
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text(
                'Web support is highly experimental, your secrets are stored inside the browser.'),
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
  void initState() {
    super.initState();

    if (mounted) {
      Future.delayed(Duration.zero, () => _showWebWarningDialog());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
