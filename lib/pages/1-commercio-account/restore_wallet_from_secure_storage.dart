import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
import 'package:flutter/material.dart';

class RestoreWalletFromSecureStoragePage extends SectionPageWidget {
  const RestoreWalletFromSecureStoragePage({Key key})
      : super('/1-account/restore-wallet-from-secure-storage',
            'RestoreWalletFromSecureStoragePage',
            key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
        bodyWidget: RestoreWalletFromSecureStoragePageBody());
  }
}

class RestoreWalletFromSecureStoragePageBody extends StatelessWidget {
  const RestoreWalletFromSecureStoragePageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                RestoreWalletWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RestoreWalletWidget extends StatelessWidget {
  const RestoreWalletWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to restore the wallet using the safely saved mnemonic string.',
            padding: EdgeInsets.all(5.0),
          ),
          RestoreWalletFlatButton(
            accountEventCallback: () =>
                const CommercioAccountRestoreWalletEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Restore Wallet',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreWalletTextField(
                readOnly: true,
                loadingTextCallback: () => 'Loading...',
                textCallback: (state) => state.commercioAccount.walletAddress),
          ),
        ],
      ),
    );
  }
}
