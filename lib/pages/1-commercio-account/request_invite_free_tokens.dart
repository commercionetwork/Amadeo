import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/presenters/account_request_response_presenter.dart';
import 'package:amadeo/presenters/faucet_invite_presenter.dart';
import 'package:amadeo/widgets/base_list_widget.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commercio_ui/flutter_commercio_ui.dart';

class RequestInviteFreeTokensPage extends SectionPageWidget {
  const RequestInviteFreeTokensPage({Key? key})
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
  const RequestInviteFreeTokensPageBody({Key? key}) : super(key: key);

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
  const RequestFaucetInviteWidget({Key? key}) : super(key: key);

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
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Request faucet invite',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RequestFaucetInviteTextField(
            loading: (_) => 'Requesting...',
            text: (_, state) => state.maybeWhen(
              (response) => faucetInviteResponseToString(response),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}

class RequestFreeTokensWidget extends StatelessWidget {
  const RequestFreeTokensWidget({Key? key}) : super(key: key);

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
                buttonStyle: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: (_) => const Text(
                  'Request free tokens',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          RequestFreeTokensTextField(
            loading: (_) => 'Loading...',
            text: (_, state) => state.maybeWhen(
              (accountRequestResponse) =>
                  accountRequestResponseToString(accountRequestResponse),
              orElse: () => '',
            ),
          ),
        ],
      ),
    );
  }
}
