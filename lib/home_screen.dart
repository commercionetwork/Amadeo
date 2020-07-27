import 'package:amadeo/entities/section_page.dart';
import 'package:amadeo/helpers/warning_dialog_bloc/warning_dialog_bloc.dart';
import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/section_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<SectionPage> sections = const [
    SectionPage(
      sectionPageWidget: CommercioAccountPage(),
      title: 'Commercio Account',
      description: 'Create a Wallet, Sign and Send a Blockchain Transaction',
    ),
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
          'Electronically sign any PDF and XML digital document so no-one can deny having digitally signed the document',
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

  void _showWebWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            'Web support is highly experimental, your secrets are stored inside the browser.',
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

  void _showDeskopbWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
            'Desktop support is highly experimental, your secrets are stored inside a temporary and insecure storage.',
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => BlocProvider.of<WarningDialogBloc>(context).add(
        const MaybeShowWebWarningDialogEvent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocListener<WarningDialogBloc, WarningDialogState>(
        listener: (context, state) {
          if (state is ShowWebWarningDialogState) {
            _showWebWarningDialog(context);
          }

          if (state is ShowDesktopWarningDialogState) {
            _showDeskopbWarningDialog(context);
          }
        },
        child: ListView.builder(
          itemCount: sections.length,
          itemBuilder: (context, i) => SectionCardWidget(
            sectionPage: sections[i],
          ),
        ),
      ),
    );
  }
}
