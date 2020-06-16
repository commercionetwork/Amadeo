import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                CloseCdpWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CloseCdpWidget extends StatelessWidget {
  final TextEditingController blockHeightTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: blockHeightTextController,
            decoration: const InputDecoration(
                hintText: '46487',
                labelText: 'Block height of the previously opened CDP'),
          ),
          const ParagraphWidget(
            'Press the button to close a Cdp at height at the specified block height.',
            padding: EdgeInsets.all(5.0),
          ),
          CloseCdpFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Closing...',
              style: TextStyle(color: Colors.white),
            ),
            accountEventCallback: () => CommercioMintCloseCdpEvent(
              blockHeight: int.tryParse(blockHeightTextController.text),
            ),
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
