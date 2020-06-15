import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
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
              children: const [
                RestoreWalletFromMnemonicWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RestoreWalletFromMnemonicWidget extends StatefulWidget {
  const RestoreWalletFromMnemonicWidget();

  @override
  _RestoreWalletFromMnemonicWidgetState createState() =>
      _RestoreWalletFromMnemonicWidgetState();
}

class _RestoreWalletFromMnemonicWidgetState
    extends State<RestoreWalletFromMnemonicWidget> {
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
          BlocBuilder<CommercioAccountBloc, CommercioAccountState>(
              builder: (_, snap) {
            final f = (snap is CommercioAccountLoadingGenerateWallet)
                ? null
                : () => BlocProvider.of<CommercioAccountBloc>(context).add(
                      CommercioAccountGenerateNewWalletEvent(
                        mnemonic: mnemonicTextController.text,
                      ),
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
          }),
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
