import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CommercioAccountPage extends SectionPageWidget {
  const CommercioAccountPage({Key key})
      : super(Routes.commercioAccountPage, 'CommercioAccountPage', key: key);

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
          child: Center(
            child: Column(
              children: const [
                GenerateWalletWidget(),
                RestoreWalletWidget(),
                RequestFreeTokensWidget(),
                CheckAccountBalanceWidget(),
                SendTokensWidget(),
                GenerateQrCodeWidget(),
                GeneratePairwiseWalletWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenerateWalletWidget extends StatelessWidget {
  const GenerateWalletWidget();

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

class RequestFreeTokensWidget extends StatelessWidget {
  const RequestFreeTokensWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to request free tokens for the current wallet.',
            padding: EdgeInsets.all(5.0),
          ),
          RequestFreeTokensFlatButton(
            child: () => const Text(
              'Request free tokens',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestFreeTokensTextField(
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.accountRequestResponse.isSuccess
                  ? 'Success! Hash: ${state.accountRequestResponse.message}'
                  : 'Error: ${state.accountRequestResponse.message}',
            ),
          ),
        ],
      ),
    );
  }
}

class CheckAccountBalanceWidget extends StatelessWidget {
  const CheckAccountBalanceWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to check the account balance.',
            padding: EdgeInsets.all(5.0),
          ),
          CheckBalanceFlatButton(
            child: () => const Text(
              'Check balance',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Checking...',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CheckBalanceTextField(
                loadingTextCallback: () => 'Checking...',
                textCallback: (state) => state.balance.fold(
                    '',
                    (prev, curr) =>
                        '$prev ${prev.isEmpty ? '' : ','} Amount ${curr.amount} of ${curr.denom}')),
          ),
        ],
      ),
    );
  }
}

class SendTokensWidget extends StatelessWidget {
  const SendTokensWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to send 100 ucommercio coins.',
            padding: EdgeInsets.all(5.0),
          ),
          SendTokensFlatButton(
            child: () => const Text('Send tokens',
                style: TextStyle(color: Colors.white)),
            loadingChild: () => const Text(
              'Sending...',
              style: TextStyle(color: Colors.white),
            ),
            recipientAddress: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
            amount: const [CommercioCoin(amount: '100')],
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SendTokensTextField(
              loadingTextCallback: () => 'Sending...',
              textCallback: (state) => state.result.success
                  ? 'Success! Hash: ${state.result.hash}'
                  : 'Error: ${jsonEncode(state.result.error)}',
            ),
          ),
        ],
      ),
    );
  }
}

class GenerateQrCodeWidget extends StatelessWidget {
  const GenerateQrCodeWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate a QR code from your wallet.',
            padding: EdgeInsets.all(5.0),
          ),
          GenerateQrFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            child: () => const Text(
              'Generate QR',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Generating...',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: BlocBuilder<CommercioAccountBloc, CommercioAccountState>(
                builder: (context, state) {
              if (state is CommercioAccountQrWithWallet) {
                return QrImage(data: state.commercioAccount.walletAddress);
              }

              return Container();
            }),
          ),
        ],
      ),
    );
  }
}

class GeneratePairwiseWalletWidget extends StatelessWidget {
  const GeneratePairwiseWalletWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate a pairwise wallet.',
            padding: EdgeInsets.all(5.0),
          ),
          GeneratePairwiseWalletFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            child: () => const Text(
              'Generate pairwise wallet',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Generating...',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GeneratePairwiseWalletTextField(
                readOnly: true,
                loadingTextCallback: () => 'Loading...',
                textCallback: (state) => state.wallet.bech32Address),
          ),
        ],
      ),
    );
  }
}
