import 'package:amadeo/pages/export.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                SubSectionWidget(
                  sectionPage: OpenCdpPage(),
                  title: '5.1 Opening a Collateral Debt Position',
                ),
                SubSectionWidget(
                  sectionPage: CloseCdpPage(),
                  title: '5.2 Closing a Collateral Debt Position',
                ),
                SubSectionWidget(
                  sectionPage: CheckAccountBalancePage(),
                  title: '5.3 Check an account CCC balance',
                ),
                SubSectionWidget(
                  sectionPage: SendTokensPage(),
                  title: '5.4 Send a Credit (CCC) to another address',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
