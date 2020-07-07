import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateNewWalletPage extends SectionPageWidget {
  const GenerateNewWalletPage({Key key})
      : super(
          '/1-account/generate-new-wallet',
          'GenerateNewWalletPage',
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: GenerateNewWalletPageBody());
  }
}

class GenerateNewWalletPageBody extends StatelessWidget {
  const GenerateNewWalletPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioAccountGenerateWalletBloc(
            commercioAccount: RepositoryProvider.of<StatefulCommercioAccount>(
              context,
            ),
          ),
          child: const GenerateWalletWidget(),
        ),
      ],
    );
  }
}

class GenerateWalletWidget extends StatefulWidget {
  const GenerateWalletWidget();

  @override
  _GenerateWalletWidgetState createState() => _GenerateWalletWidgetState();
}

class _GenerateWalletWidgetState extends State<GenerateWalletWidget> {
  final _mnemonicTextController = TextEditingController(text: '');

  @override
  void dispose() {
    _mnemonicTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to auto-generate a new wallet. The mnemonic words will be stored inside the device secure storage.',
            padding: EdgeInsets.all(5.0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GenerateWalletFlatButton(
              event: () => const CommercioAccountGenerateWalletEvent(),
              child: (_) => const Text(
                'Generate Wallet',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColorDark,
            ),
          ),
          BlocBuilder<CommercioAccountGenerateWalletBloc,
              CommercioAccountGenerateWalletState>(
            builder: (_, snap) {
              snap.when(
                (mnemonic, wallet, walletAddress) =>
                    _mnemonicTextController.text = mnemonic,
                initial: () => _mnemonicTextController.text = '',
                loading: () => _mnemonicTextController.text = 'Loading...',
                error: (_) => null,
              );

              return TextField(
                readOnly: true,
                controller: _mnemonicTextController,
                maxLines: null,
              );
            },
          ),
          GenerateWalletTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.walletAddress,
          ),
        ],
      ),
    );
  }
}
