import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/power_up_request_presenter.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:amadeo/widgets/recipient_address_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class RequestPowerupPage extends SectionPageWidget {
  const RequestPowerupPage({Key? key})
      : super('/2-id/request-powerup', 'RequestPowerupPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioIdDeriveDidPowerUpRequestBloc(
          commercioId: context.read<StatefulCommercioId>(),
        ),
        child: const RequestPowerupPageBody(),
      ),
    );
  }
}

class RequestPowerupPageBody extends StatelessWidget {
  const RequestPowerupPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioIdRechargeTumblerBloc(
            commercioId: context.read<StatefulCommercioId>(),
          ),
          child: const RechargeGovernmentWidget(),
        ),
        const DeriveDidPowerUpWidget(),
        BlocProvider(
          create: (_) => CommercioIdRequestDidPowerUpsBloc(
            commercioId: context.read<StatefulCommercioId>(),
          ),
          child: const RequestDidPowerUpWidget(),
        ),
      ],
    );
  }
}

class RechargeGovernmentWidget extends StatelessWidget {
  const RechargeGovernmentWidget({Key? key}) : super(key: key);

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
                  amount: [CommercioCoin(amount: '1000')],
                ),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Send tokens to Tumbler',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RechargeTumblerTextField(
            loading: (_) => 'Recharging...',
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

class DeriveDidPowerUpWidget extends StatefulWidget {
  const DeriveDidPowerUpWidget({Key? key}) : super(key: key);

  @override
  _DeriveDidPowerUpWidgetState createState() => _DeriveDidPowerUpWidgetState();
}

class _DeriveDidPowerUpWidgetState extends State<DeriveDidPowerUpWidget> {
  final _pairwiseAddressTextCtrl = TextEditingController(
    text: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
  );
  final _amountTextCtrl = TextEditingController(
    text: '1000',
  );

  @override
  void dispose() {
    _amountTextCtrl.dispose();
    _pairwiseAddressTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecipientAddressTextFieldWidget(
            recipientTextController: _pairwiseAddressTextCtrl,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: '1000',
              labelText: 'Amount',
            ),
            controller: _amountTextCtrl,
          ),
          const ParagraphWidget(
            'Press the button to derive a Did PowerUp request.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: DeriveDidPowerUpRequestFlatButton(
                event: () => CommercioIdDeriveDidPowerUpRequestEvent(
                  pairwiseAddress: _pairwiseAddressTextCtrl.text,
                  amount: [CommercioCoin(amount: _amountTextCtrl.text)],
                ),
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Derive Did PowerUp request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          DeriveDidPowerUpRequestTextField(
            loading: (_) => 'Deriving...',
            text: (_, state) => state.maybeWhen(
              (didPowerUpRequest) => powerUpRequestToString(didPowerUpRequest),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class RequestDidPowerUpWidget extends StatelessWidget {
  const RequestDidPowerUpWidget({Key? key}) : super(key: key);

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
              child: BlocBuilder<CommercioIdDeriveDidPowerUpRequestBloc,
                  CommercioIdDeriveDidPowerUpRequestState>(
                builder: (_, state) {
                  final fn =
                      (state is CommercioIdDeriveDidPowerUpRequestStateData)
                          ? () => CommercioIdRequestDidPowerUpsEvent(
                                powerUpRequests: [state.didPowerUpRequest],
                              )
                          : null;

                  return RequestDidPowerUpFlatButton(
                    event: fn,
                    buttonStyle: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: (_) => const Text(
                      'Request Did PowerUp',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),
          RequestDidPowerUpTextField(
            loading: (_) => 'Powering up...',
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
