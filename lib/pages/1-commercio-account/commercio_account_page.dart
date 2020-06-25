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
          child: Column(
            children: const [
              SubSectionWidget(
                sectionPage: GenerateNewWalletPage(),
                title: '1.1 Generate an HD Wallet',
                subtitle:
                    'In our case the wallet will be used to sign, with the keys contained in it, the transactions that will then be sended to the Commercio.network blockchain.',
              ),
              SubSectionWidget(
                sectionPage: RestoreWalletFromMnemonicPage(),
                title: '1.2 Restore wallet from mnemonic',
                subtitle:
                    'If users change or loose their phone they need a way to re-enter the seed phrase and recover the wallet on a new phone.',
              ),
              SubSectionWidget(
                sectionPage: RestoreWalletFromSecureStoragePage(),
                title: '1.3 Restore wallet from secure storage',
                subtitle:
                    'Retrieve safely your mnemonic in your Android and iOS device and then derive the pub address from wallet.',
              ),
              SubSectionWidget(
                sectionPage: ShareQRCodePage(),
                title: '1.4 Share QR code',
                subtitle:
                    'Generate the QR code of your address in your Android and iOS device.',
              ),
              SubSectionWidget(
                sectionPage: RequestInviteFreeTokensPage(),
                title: '1.5 Request invite and free tokens',
                subtitle:
                    'To buy a mebership first of all you have to be invited. To do anything on a blockchain you need tokens. If you are operating on a testnet you can have them for free.',
              ),
              SubSectionWidget(
                sectionPage: CheckAccountBalancePage(),
                title: '1.6 Check account balance',
                subtitle: 'Get the account balance.',
              ),
              SubSectionWidget(
                sectionPage: SendTokensPage(),
                title: '1.7 Send tokens to another address',
                subtitle: 'Send a token to another account.',
              ),
              SubSectionWidget(
                sectionPage: GenerateManyAddressesPage(),
                title: '1.8 Generate many addresses with single mnemonic',
                subtitle:
                    'Create a dedicated address derived from the same seed to pairwise every single person we interact with.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
