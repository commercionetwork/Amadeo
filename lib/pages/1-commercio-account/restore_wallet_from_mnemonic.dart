import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreWalletFromMnemonicPage extends SectionPageWidget {
  const RestoreWalletFromMnemonicPage({Key key})
      : super('/1-account/restore-wallet-from-mnemonic',
            'RestoreWalletFromMnemonicPage',
            key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
        bodyWidget: RestoreWalletFromMnemonicPageBody());
  }
}

class RestoreWalletFromMnemonicPageBody extends StatelessWidget {
  const RestoreWalletFromMnemonicPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioAccountRestoreWalletBloc>(
                  create: (_) => CommercioAccountRestoreWalletBloc(
                    commercioAccount:
                        RepositoryProvider.of<StatefulCommercioAccount>(
                      context,
                    ),
                  ),
                  child: RestoreWalletFromMnemonicWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RestoreWalletFromMnemonicWidget extends StatelessWidget {
  RestoreWalletFromMnemonicWidget();

  final TextEditingController mnemonicTextController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to restore the wallet using the entered input words.',
            padding: EdgeInsets.all(5.0),
          ),
          TextField(
            controller: mnemonicTextController,
          ),
          BlocBuilder<CommercioAccountRestoreWalletBloc,
              CommercioAccountRestoredWalletState>(
            builder: (_, snap) {
              final restoreBloc =
                  BlocProvider.of<CommercioAccountRestoreWalletBloc>(context);
              Function() f = () => restoreBloc.add(
                    CommercioAccountRestoreWalletEvent(
                      mnemonic: mnemonicTextController.text,
                    ),
                  );

              snap.when(
                (mnemonic, wallet, walletAddress) => null,
                initial: () => null,
                loading: () => f = null,
                error: (_) => null,
              );

              return FlatButton(
                onPressed: f,
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: const Text(
                  'Restore Wallet',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreWalletTextField(
              readOnly: true,
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.walletAddress,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
