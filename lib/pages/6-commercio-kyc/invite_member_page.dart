import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/tx_result_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacco/sacco.dart';

class InviteMemberPage extends SectionPageWidget {
  const InviteMemberPage({Key? key})
      : super('/6-kyc/invite-member', 'InviteMemberPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioKycDeriveInviteMemberBloc(
          commercioKyc: context.read<StatefulCommercioKyc>(),
        ),
        child: const InviteMemberPageBody(),
      ),
    );
  }
}

class InviteMemberPageBody extends StatelessWidget {
  const InviteMemberPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioKycInviteMembersBloc(
            commercioKyc: context.read<StatefulCommercioKyc>(),
          ),
          child: const InviteMemberWidget(),
        ),
      ],
    );
  }
}

class InviteMemberWidget extends StatelessWidget {
  const InviteMemberWidget({Key? key}) : super(key: key);

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
            future: const StatelessCommercioAccount().generateNewWallet(
              networkInfo:
                  context.read<StatefulCommercioAccount>().networkInfo!,
            ),
            builder: (context, snap) {
              final fn = (snap.connectionState == ConnectionState.done)
                  ? () => CommercioKycInviteMembersEvent(
                        inviteUsers: [
                          InviteUser(
                            recipientDid: snap.data!.bech32Address,
                            senderDid: context
                                .read<StatefulCommercioAccount>()
                                .walletAddress!,
                          )
                        ],
                      )
                  : null;
              final child = Text(
                (snap.connectionState == ConnectionState.done)
                    ? 'Invite new wallet'
                    : 'Generating random wallet...',
                style: const TextStyle(color: Colors.white),
              );

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: InviteMembersFlatButton(
                    event: fn,
                    buttonStyle: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: (_) => child,
                  ),
                ),
              );
            },
          ),
          InviteMembersTextField(
            loading: (_) => 'Inviting...',
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
