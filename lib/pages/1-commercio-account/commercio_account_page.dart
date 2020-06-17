import 'package:amadeo/pages/export.dart';
import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioAccountPage extends SectionPageWidget {
  const CommercioAccountPage({Key key})
      : super('/1-account', 'CommercioAccountPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(bodyWidget: CommercioAccountBody());
  }
}

class CommercioAccountBody extends StatelessWidget {
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
                  sectionPage: GenerateNewWalletPage(),
                  title: '1.1 Generate an HD Wallet',
                ),
                SubSectionWidget(
                  sectionPage: RestoreWalletFromMnemonicPage(),
                  title: '1.2 Restore wallet from mnemonic',
                ),
                SubSectionWidget(
                  sectionPage: RestoreWalletFromSecureStoragePage(),
                  title: '1.3 Restore wallet from secure storage',
                ),
                SubSectionWidget(
                  sectionPage: ShareQRCodePage(),
                  title: '1.4 Share QR code',
                ),
                SubSectionWidget(
                  sectionPage: RequestInviteFreeTokensPage(),
                  title: '1.5 Request invite and free tokens',
                ),
                SubSectionWidget(
                  sectionPage: CheckAccountBalancePage(),
                  title: '1.6 Check account balance',
                ),
                SubSectionWidget(
                  sectionPage: SendTokensPage(),
                  title: '1.7 Send tokens to another address',
                ),
                SubSectionWidget(
                  sectionPage: GenerateManyAddressesPage(),
                  title: '1.8 Generate many addresses with single mnemonic',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
