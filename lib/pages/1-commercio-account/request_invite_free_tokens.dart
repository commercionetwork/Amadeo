import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/account_request_response_presenter.dart';
import 'package:amadeo/presenters/faucet_invite_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestInviteFreeTokensPage extends SectionPageWidget {
  const RequestInviteFreeTokensPage({Key key})
      : super(
          '/1-account/request-invite-free-tokens',
          'RequestInviteFreeTokensPage',
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return const BaseScaffoldWidget(
      bodyWidget: RequestInviteFreeTokensPageBody(),
    );
  }
}

class RequestInviteFreeTokensPageBody extends StatelessWidget {
  const RequestInviteFreeTokensPageBody();

  @override
  Widget build(BuildContext context) {
    return BaseListWidget(
      separatorIndent: .0,
      separatorEndIndent: .0,
      children: [
        BlocProvider(
          create: (_) => CommercioKycRequestFaucetInviteBloc(
            commercioKyc: RepositoryProvider.of<StatefulCommercioKyc>(
              context,
            ),
          ),
          child: const RequestFaucetInviteWidget(),
        ),
        BlocProvider(
          create: (_) => CommercioAccountRequestFreeTokensBloc(
            commercioAccount: RepositoryProvider.of<StatefulCommercioAccount>(
              context,
            ),
          ),
          child: const RequestFreeTokensWidget(),
        ),
      ],
    );
  }
}

class RequestFaucetInviteWidget extends StatelessWidget {
  const RequestFaucetInviteWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget('Request an invite from the faucet.'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: RequestFaucetInviteFlatButton(
                event: () => const CommercioKycRequestFaucetInviteEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
                child: (_) => const Text(
                  'Request faucet invite',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RequestFaucetInviteTextField(
            loading: (_) => 'Requesting...',
            text: (_, state) => faucetInviteResponseToString(state.response),
          ),
        ],
      ),
    );
  }
}

class RequestFreeTokensWidget extends StatelessWidget {
  const RequestFreeTokensWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ParagraphWidget(
            'Request free tokens from the faucet.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: RequestFreeTokensFlatButton(
                event: () => const CommercioAccountRequestFreeTokensEvent(),
                color: Theme.of(context).primaryColor,
                disabledColor: Theme.of(context).disabledColor,
                child: (_) => const Text(
                  'Request free tokens',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RequestFreeTokensTextField(
            loading: (_) => 'Loading...',
            text: (_, state) =>
                accountRequestResponseToString(state.accountRequestResponse),
          ),
        ],
      ),
    );
  }
}
