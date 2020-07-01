import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              children: [
                MultiBlocProvider(
                  providers: [
                    BlocProvider<CommercioAccountRestoreWalletBloc>(
                      create: (_) => CommercioAccountRestoreWalletBloc(
                        commercioAccount:
                            RepositoryProvider.of<StatefulCommercioAccount>(
                          context,
                        ),
                      ),
                    ),
                  ],
                  child: const RestoreWalletWidget(),
                )
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
            event: () => const CommercioAccountRestoreWalletEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Restore Wallet',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreWalletTextField(
              readOnly: true,
              loading: (_) => 'Loading...',
              text: (_, state) => state.walletAddress,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
