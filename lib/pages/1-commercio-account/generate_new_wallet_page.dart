import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateNewWalletPage extends SectionPageWidget {
  const GenerateNewWalletPage({Key key})
      : super('/1-account/generate-new-wallet', 'GenerateNewWalletPage',
            key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: GenerateNewWalletPageBody());
  }
}

class GenerateNewWalletPageBody extends StatelessWidget {
  const GenerateNewWalletPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                GenerateWalletWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenerateWalletWidget extends StatelessWidget {
  GenerateWalletWidget();

  final TextEditingController mnemonicTextController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to auto-generate a new wallet. The mnemonic words will be stored inside the device secure storage.',
            padding: EdgeInsets.all(5.0),
          ),
          GenerateWalletFlatButton(
            accountEventCallback: () =>
                const CommercioAccountGenerateNewWalletEvent(),
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Generate Wallet',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          BlocBuilder<CommercioAccountBloc, CommercioAccountState>(
              builder: (_, snap) {
            if (snap is CommercioAccountInitial) {
              mnemonicTextController.text = '';
            }

            if (snap is CommercioAccountGeneratedWithWallet) {
              mnemonicTextController.text = snap.commercioAccount.mnemonic;
            }

            return TextField(
              readOnly: true,
              controller: mnemonicTextController,
            );
          }),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GenerateWalletTextField(
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.commercioAccount.walletAddress,
            ),
          ),
        ],
      ),
    );
  }
}
