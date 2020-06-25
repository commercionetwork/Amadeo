import 'dart:convert';

import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacco/sacco.dart';

class InviteMemberPage extends SectionPageWidget {
  const InviteMemberPage({Key key})
      : super('/6-kyc/invite-member', 'InviteMemberPage', key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: InviteMemberPageBody(),
    );
  }
}

class InviteMemberPageBody extends StatelessWidget {
  const InviteMemberPageBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioKycInviteMemberBloc>(
                  create: (_) => CommercioKycInviteMemberBloc(
                    commercioKyc:
                        RepositoryProvider.of<StatefulCommercioKyc>(context),
                  ),
                  child: const InviteMemberWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
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
                  networkInfo:
                      RepositoryProvider.of<StatefulCommercioAccount>(context)
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
                  accountEventCallback: () => CommercioKycInviteMemberEvent(
                    invitedAddress: snap.data.bech32Address,
                  ),
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColorDark,
                  loadingChild: () => const Text(
                    'Inviting...',
                    style: TextStyle(color: Colors.white),
                  ),
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
              textCallback: (state) => jsonEncode(state.result),
            ),
          ),
        ],
      ),
    );
  }
}
