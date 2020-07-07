import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioIdRechargeTumblerBloc(
            commercioId: RepositoryProvider.of<StatefulCommercioId>(
              context,
            ),
          ),
          child: const RechargeGovernmentWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioIdRequestDidPowerUpBloc(
            commercioId: RepositoryProvider.of<StatefulCommercioId>(
              context,
            ),
          ),
          child: const RequestDidPowerUpWidget(),
        ),
      ],
    );
  }
}

class RechargeGovernmentWidget extends StatelessWidget {
  const RechargeGovernmentWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to send tokens to the Tumbler.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: RechargeTumblerFlatButton(
                event: () => const CommercioIdRechargeTumblerEvent(
                  rechargeAmount: [CommercioCoin(amount: '1000')],
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Send tokens to Tumbler',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RechargeTumblerTextField(
            loading: (_) => 'Recharging...',
            text: (_, state) => txResultToString(state.result),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Press the button to request a Did PowerUp.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: RequestDidPowerUpFlatButton(
                event: () => const CommercioIdRequestDidPowerUpEvent(
                  amount: [CommercioCoin(amount: '1000')],
                  pairwiseAddress:
                      'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
                ),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).primaryColorDark,
                child: (_) => const Text(
                  'Request Did PowerUp',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RequestDidPowerUpTextField(
            loading: (_) => 'Powering up...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
