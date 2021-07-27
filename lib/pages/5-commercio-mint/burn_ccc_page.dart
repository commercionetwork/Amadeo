import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class BurnCccPage extends SectionPageWidget {
  const BurnCccPage({Key? key})
      : super('/5-mint/burn-ccc', 'BurnCccPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: BurnCccPageBody(),
    );
  }
}

class BurnCccPageBody extends StatelessWidget {
  const BurnCccPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioMintBurnCccBloc(
            commercioMint:
                RepositoryProvider.of<StatefulCommercioMint>(context),
          ),
          child: const BurnCccWidget(),
        ),
      ],
    );
  }
}

class BurnCccWidget extends StatefulWidget {
  const BurnCccWidget({Key? key}) : super(key: key);

  @override
  _BurnCccWidgetState createState() => _BurnCccWidgetState();
}

class _BurnCccWidgetState extends State<BurnCccWidget> {
  final _mintUuidController = TextEditingController();
  final _burnAmountController = TextEditingController();
  late final StatefulCommercioAccount commAccount;

  @override
  void initState() {
    commAccount = context.read<StatefulCommercioAccount>();
    super.initState();
  }

  @override
  void dispose() {
    _mintUuidController.dispose();
    _burnAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final button = BurnCccFlatButton(
      buttonStyle: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      event: commAccount.hasWalletAddress
          ? () => CommercioMintBurnCCCEvent(
                burnCccs: [
                  BurnCcc(
                    signerDid: commAccount.walletAddress!,
                    amount: CommercioCoin(amount: _burnAmountController.text),
                    id: _mintUuidController.text,
                  )
                ],
              )
          : null,
      child: (_) => const Text(
        'Close Cdp',
        style: TextStyle(color: Colors.white),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _mintUuidController,
            decoration: const InputDecoration(
              hintText: '28f71cee-efdf-445e-a98a-f3748b11c679',
              labelText: 'Mint UUID',
            ),
          ),
          TextField(
            controller: _burnAmountController,
            decoration: const InputDecoration(
              hintText: '1000',
              labelText: 'Amount to burn',
            ),
          ),
          const ParagraphWidget(
            'Press the button to burn previously minteted CCC.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: commAccount.hasWalletAddress
                  ? button
                  : Tooltip(
                      message: 'Must have a wallet',
                      child: button,
                    ),
            ),
          ),
          BurnCccTextField(
            loading: (_) => 'Burning...',
            text: (_, state) => state.maybeWhen(
              (result) => txResultToString(result),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
