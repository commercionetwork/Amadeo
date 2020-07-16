import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commerciosdk/export.dart' hide Padding, Key;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CloseCdpPage extends SectionPageWidget {
  const CloseCdpPage({Key key})
      : super('/5-mint/close-cdp', 'CloseCdpPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: CloseCdpPageBody(),
    );
  }
}

class CloseCdpPageBody extends StatelessWidget {
  const CloseCdpPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioMintCloseCdpsBloc(
            commercioMint:
                RepositoryProvider.of<StatefulCommercioMint>(context),
          ),
          child: const CloseCdpWidget(),
        ),
      ],
    );
  }
}

class CloseCdpWidget extends StatefulWidget {
  const CloseCdpWidget();

  @override
  _CloseCdpWidgetState createState() => _CloseCdpWidgetState();
}

class _CloseCdpWidgetState extends State<CloseCdpWidget> {
  final _blockHeightTextController = TextEditingController();

  @override
  void dispose() {
    _blockHeightTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commAccount = context.repository<StatefulCommercioAccount>();
    final button = CloseCdpsFlatButton(
      color: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).disabledColor,
      event: commAccount.hasWalletAddress
          ? () => CommercioMintCloseCdpsEvent(
                closeCdps: [
                  CloseCdp(
                    signerDid: null,
                    timeStamp: _blockHeightTextController.text,
                  ),
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
            controller: _blockHeightTextController,
            decoration: const InputDecoration(
              hintText: '46487',
              labelText: 'Block height of the previously opened CDP',
            ),
          ),
          const ParagraphWidget(
            'Press the button to close a Cdp at height at the specified block height.',
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
          CloseCdpsTextField(
            loading: (_) => 'Closing...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
