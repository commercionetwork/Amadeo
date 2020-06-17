import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/ui/account/commercio_account_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareQRCodePage extends SectionPageWidget {
  const ShareQRCodePage({Key key})
      : super('/1-account/share-qr-code', 'ShareQRCodePage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(bodyWidget: ShareQRCodePageBody());
  }
}

class ShareQRCodePageBody extends StatelessWidget {
  const ShareQRCodePageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                GenerateQrCodeWidget(),
              ],
            ),
          ),
        ),
      ],
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
