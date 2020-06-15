import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';

class RequestPowerupPage extends SectionPageWidget {
  const RequestPowerupPage({Key key})
      : super('/2-id/request-powerup', 'RequestPowerupPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: RequestPowerupPageBody(),
    );
  }
}

class RequestPowerupPageBody extends StatelessWidget {
  const RequestPowerupPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                RechargeGovernmentWidget(),
                RequestDidPowerUpWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RechargeGovernmentWidget extends StatelessWidget {
  const RechargeGovernmentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to send tokens to the Tumbler.',
            padding: EdgeInsets.all(5.0),
          ),
          RechargeGovernmentFlatButton(
            accountEventCallback: () =>
                const CommercioIdRechargeGovernmentEvent(
                    rechargeAmount: [CommercioCoin(amount: '1000')]),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Recharging...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Send tokens to Tumbler',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RechargeGovernmentCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Recharging...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class RequestDidPowerUpWidget extends StatelessWidget {
  const RequestDidPowerUpWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to request a Did PowerUp.',
            padding: EdgeInsets.all(5.0),
          ),
          RequestDidPowerUpFlatButton(
            accountEventCallback: () => const CommercioIdRequestDidPowerUpEvent(
              amount: [CommercioCoin(amount: '1000')],
              pairwiseAddress:
                  'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Powering up...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Request Did PowerUp',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestDidPowerUpCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Powering up...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}
