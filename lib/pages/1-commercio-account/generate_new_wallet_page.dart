import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
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
                BlocProvider<CommercioAccountGenerateWalletBloc>(
                  create: (_) => CommercioAccountGenerateWalletBloc(
                    commercioAccount:
                        RepositoryProvider.of<StatefulCommercioAccount>(
                      context,
                    ),
                  ),
                  child: GenerateWalletWidget(),
                ),
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
                const CommercioAccountGenerateWalletEvent(),
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
          BlocBuilder<CommercioAccountGenerateWalletBloc,
              CommercioAccountGenerateWalletState>(
            builder: (_, snap) {
              snap.when(
                (mnemonic, wallet, walletAddress) =>
                    mnemonicTextController.text = mnemonic,
                initial: () => mnemonicTextController.text = '',
                loading: () => mnemonicTextController.text = 'Loading...',
                error: (_) => null,
              );

              return TextField(
                readOnly: true,
                controller: mnemonicTextController,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GenerateWalletTextField(
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.walletAddress,
            ),
          ),
        ],
      ),
    );
  }
}
