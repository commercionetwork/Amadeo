import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioMintPage extends SectionPageWidget {
  const CommercioMintPage({Key key})
      : super('/5-mint', 'CommercioMintPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(bodyWidget: CommercioMintBody());
  }
}

class CommercioMintBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const BaseListWidget(
      children: [
        SubSectionWidget(
          sectionPage: OpenCdpPage(),
          title: '5.1 Opening a Collateral Debt Position',
          subtitle:
              'Opens a new CDP depositing the given Commercio Token amount.',
        ),
        SubSectionWidget(
          sectionPage: CloseCdpPage(),
          title: '5.2 Closing a Collateral Debt Position',
          subtitle: 'Closes the CDP having the given timestamp (height).',
        ),
        SubSectionWidget(
          sectionPage: CheckAccountBalancePage(),
          title: '5.3 Check an account CCC balance',
          subtitle: 'Get the account CCC balance.',
        ),
        SubSectionWidget(
          sectionPage: SendTokensPage(),
          title: '5.4 Send a Credit (CCC) to another address',
          subtitle: 'Send a Commercio Cash Credit (CCC) to another account.',
        ),
      ],
    );
  }
}
