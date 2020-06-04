import 'dart:convert';

import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/mint/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommercioMintPage extends SectionPageWidget {
  const CommercioMintPage({Key key})
      : super(Routes.commercioMintPage, 'CommercioMintPage', key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioMintBloc>(
      create: (_) => CommercioMintBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioMintBody()),
    );
  }
}

class CommercioMintBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                OpenCdpWidget(),
                CloseCdpWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OpenCdpWidget extends StatelessWidget {
  final int amount = 1000;

  const OpenCdpWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ParagraphWidget(
            'Press the button to open a Cdp with $amount amount.',
            padding: const EdgeInsets.all(5.0),
          ),
          OpenCdpFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Opening...',
              style: TextStyle(color: Colors.white),
            ),
            amount: amount,
            child: () => const Text(
              'Open Cdp',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: OpenCdpTextField(
                readOnly: true,
                loadingTextCallback: () => 'Opening...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class CloseCdpWidget extends StatelessWidget {
  final int blockHeight = 524187;

  const CloseCdpWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ParagraphWidget(
            'Press the button to close a Cdp at height $blockHeight.',
            padding: const EdgeInsets.all(5.0),
          ),
          CloseCdpFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Closing...',
              style: TextStyle(color: Colors.white),
            ),
            blockHeight: blockHeight,
            child: () => const Text(
              'Close Cdp',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CloseCdpTextField(
                readOnly: true,
                loadingTextCallback: () => 'Closing...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}
