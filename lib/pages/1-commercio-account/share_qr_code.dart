import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioAccountGenerateQrBloc(
            commercioAccount: RepositoryProvider.of<StatefulCommercioAccount>(
              context,
            ),
          ),
          child: const GenerateQrCodeWidget(),
        ),
      ],
    );
  }
}

class GenerateQrCodeWidget extends StatelessWidget {
  const GenerateQrCodeWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate a QR code from your wallet.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GenerateQrFlatButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColorDark,
              child: (_) => const Text(
                'Generate QR',
                style: TextStyle(color: Colors.white),
              ),
              loading: (_) => const Text(
                'Generating...',
                style: TextStyle(color: Colors.white),
              ),
              event: () => const CommercioAccountGenerateQrEvent(),
            ),
          ),
          BlocBuilder<CommercioAccountGenerateQrBloc, CommercioAccountQrState>(
            builder: (context, state) {
              return state.when(
                (walletAddress) => QrImage(data: walletAddress),
                initial: () => Container(),
                loading: () => const CircularProgressIndicator(),
                error: (_) => Container(),
              );
            },
          ),
        ],
      ),
    );
  }
}
