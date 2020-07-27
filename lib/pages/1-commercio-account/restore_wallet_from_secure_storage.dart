import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreWalletFromSecureStoragePage extends SectionPageWidget {
  const RestoreWalletFromSecureStoragePage({Key key})
      : super(
          '/1-account/restore-wallet-from-secure-storage',
          'RestoreWalletFromSecureStoragePage',
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: RestoreWalletFromSecureStoragePageBody(),
    );
  }
}

class RestoreWalletFromSecureStoragePageBody extends StatelessWidget {
  const RestoreWalletFromSecureStoragePageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        MultiBlocProvider(
          providers: [
            BlocProvider(
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
    );
  }
}

class RestoreWalletWidget extends StatelessWidget {
  const RestoreWalletWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to restore the wallet using the safely saved mnemonic string.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RestoreWalletFlatButton(
              event: () => const CommercioAccountRestoreWalletEvent(),
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).disabledColor,
              child: (_) => const Text(
                'Restore Wallet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          RestoreWalletTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.walletAddress,
          ),
        ],
      ),
    );
  }
}
