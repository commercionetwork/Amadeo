import 'dart:convert';

import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/account/bloc/commercio_account_bloc.dart';
import 'package:commercio_ui/ui/membership/export.dart';
import 'package:commerciosdk/export.dart' as sdk;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacco/wallet.dart';

class CommercioMembershipPage extends SectionPageWidget {
  const CommercioMembershipPage({Key key})
      : super(Routes.commercioMembershipPage, 'CommercioMembershipPage',
            key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioMembershipBloc>(
      create: (_) => CommercioMembershipBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioMembershipBody()),
    );
  }
}

class CommercioMembershipBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: const [
                RequestFaucetInviteWidget(),
                BuyMembershipWidget(),
                InviteMemberWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RequestFaucetInviteWidget extends StatelessWidget {
  const RequestFaucetInviteWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Request an invite from the faucet.',
            padding: EdgeInsets.all(5.0),
          ),
          RequestFaucetInviteFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Requesting...',
              style: TextStyle(color: Colors.white),
            ),
            child: () => const Text(
              'Request faucet invite',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestFaucetInviteTextField(
                readOnly: true,
                loadingTextCallback: () => 'Requesting...',
                textCallback: (state) => state.result),
          ),
        ],
      ),
    );
  }
}

class BuyMembershipWidget extends StatelessWidget {
  final sdk.MembershipType membershipType = sdk.MembershipType.BRONZE;

  const BuyMembershipWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Buy a membership for the current account.',
            padding: EdgeInsets.all(5.0),
          ),
          BuyMembershipFlatButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loadingChild: () => const Text(
              'Buying...',
              style: TextStyle(color: Colors.white),
            ),
            membershipType: membershipType,
            child: () => const Text(
              'Buy membership',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: BuyMembershipTextField(
                readOnly: true,
                loadingTextCallback: () => 'Buying...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}

class InviteMemberWidget extends StatelessWidget {
  const InviteMemberWidget();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Invite a new random wallet address.',
            padding: EdgeInsets.all(5.0),
          ),
          FutureBuilder<Wallet>(
              future: StatelessCommercioAccount.generateNewWallet(
                  networkInfo: BlocProvider.of<CommercioAccountBloc>(context)
                      .commercioAccount
                      .networkInfo),
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return FlatButton(
                    onPressed: null,
                    disabledColor: Theme.of(context).primaryColorDark,
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Invite new wallet',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return InviteMemberFlatButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColorDark,
                  loadingChild: () => const Text(
                    'Inviting...',
                    style: TextStyle(color: Colors.white),
                  ),
                  invitedAddress: snap.data.bech32Address,
                  child: () => const Text(
                    'Invite new wallet',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: InviteMemberTextField(
                readOnly: true,
                loadingTextCallback: () => 'Inviting...',
                textCallback: (state) => jsonEncode(state.transactionResult)),
          ),
        ],
      ),
    );
  }
}
