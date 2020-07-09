import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
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
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioKycInviteMemberBloc(
            commercioKyc: RepositoryProvider.of<StatefulCommercioKyc>(context),
          ),
          child: const InviteMemberWidget(),
        ),
      ],
    );
  }
}

class InviteMemberWidget extends StatelessWidget {
  const InviteMemberWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Invite a new random wallet address.',
            padding: EdgeInsets.all(5.0),
          ),
          FutureBuilder<Wallet>(
            future: StatelessCommercioAccount.generateNewWallet(
              networkInfo:
                  RepositoryProvider.of<StatefulCommercioAccount>(context)
                      .networkInfo,
            ),
            builder: (_, snap) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: InviteMemberFlatButton(
                    event: (snap.connectionState == ConnectionState.done)
                        ? () => CommercioKycInviteMemberEvent(
                              invitedAddress: snap.data.bech32Address,
                            )
                        : null,
                    color: Theme.of(context).primaryColor,
                    disabledColor: Colors.grey,
                    child: (_) => const Text(
                      'Invite new wallet',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          InviteMemberTextField(
            loading: (_) => 'Inviting...',
            text: (_, state) => txResultToString(state.result),
          ),
        ],
      ),
    );
  }
}
