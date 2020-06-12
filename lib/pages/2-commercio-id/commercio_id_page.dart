import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/id/bloc/commercio_id_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommercioIdPage extends SectionPageWidget {
  const CommercioIdPage({Key key})
      : super('/2-id', 'CommercioIdPage', key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioIdBloc>(
      create: (_) => CommercioIdBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioIdBody()),
    );
  }
}

class CommercioIdBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                GenerateKeysWidget(),
                RestoreKeysWidget(),
                DeriveDidDocumentWidget(),
                SetDidDocumentWidget(),
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

class GenerateKeysWidget extends StatelessWidget {
  const GenerateKeysWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to generate new RSA keys.',
            padding: EdgeInsets.all(5.0),
          ),
          GenerateKeysFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Generating...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Generate keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GenerateKeysCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Generating...',
                textCallback: (state) =>
                    jsonEncode(state.commercioId.commercioIdKeys)),
          ),
        ],
      ),
    );
  }
}

class RestoreKeysWidget extends StatelessWidget {
  const RestoreKeysWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to restore the RSA keys.',
            padding: EdgeInsets.all(5.0),
          ),
          RestoreKeysFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Restoring...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Restore keys',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RestoreKeysCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Restoring...',
                textCallback: (state) =>
                    jsonEncode(state.commercioId.commercioIdKeys)),
          ),
        ],
      ),
    );
  }
}

class DeriveDidDocumentWidget extends StatelessWidget {
  const DeriveDidDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive a Did document.',
            padding: EdgeInsets.all(5.0),
          ),
          DeriveDidDocumentFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Deriving...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Derive document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DeriveDidDocumentCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Deriving...',
                textCallback: (state) => jsonEncode(state.didDocument)),
          ),
        ],
      ),
    );
  }
}

class SetDidDocumentWidget extends StatelessWidget {
  const SetDidDocumentWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Press the button to derive and set a Did document.',
            padding: EdgeInsets.all(5.0),
          ),
          SetDidDocumentFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Setting...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Set document',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SetDidDocumentCommercioIdTextField(
                readOnly: true,
                loadingTextCallback: () => 'Setting...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
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
            'Press the button to recharge the government.',
            padding: EdgeInsets.all(5.0),
          ),
          RechargeGovernmentFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Recharging...',
              style: TextStyle(color: Colors.white),
            ),
            rechargeAmount: const [CommercioCoin(amount: '1000')],
            child: () => const Text(
              'Recharge government',
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
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Powering up...',
              style: TextStyle(color: Colors.white),
            ),
            amount: const [CommercioCoin(amount: '1000')],
            pairwiseAddress: 'did:com:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau',
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
