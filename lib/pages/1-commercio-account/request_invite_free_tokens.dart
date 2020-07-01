import 'package:amadeo/pages/section_page.dart';
import 'package:amadeo/widgets/base_scaffold_widget.dart';
import 'package:amadeo/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestInviteFreeTokensPage extends SectionPageWidget {
  const RequestInviteFreeTokensPage({Key key})
      : super('/1-account/request-invite-free-tokens',
            'RequestInviteFreeTokensPage',
            key: key);

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                BlocProvider<CommercioKycRequestFaucetInviteBloc>(
                  create: (_) => CommercioKycRequestFaucetInviteBloc(
                    commercioKyc: RepositoryProvider.of<StatefulCommercioKyc>(
                      context,
                    ),
                  ),
                  child: const RequestFaucetInviteWidget(),
                ),
                BlocProvider<CommercioAccountRequestFreeTokensBloc>(
                  create: (_) => CommercioAccountRequestFreeTokensBloc(
                    commercioAccount:
                        RepositoryProvider.of<StatefulCommercioAccount>(
                      context,
                    ),
                  ),
                  child: const RequestFreeTokensWidget(),
                ),
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
            event: () => const CommercioKycRequestFaucetInviteEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Requesting...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Request faucet invite',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestFaucetInviteTextField(
              readOnly: true,
              loading: (_) => 'Requesting...',
              text: (_, state) => state.result,
              maxLines: null,
            ),
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
    return Card(
      child: Column(
        children: [
          const ParagraphWidget(
            'Request free tokens from the faucet.',
            padding: EdgeInsets.all(5.0),
          ),
          RequestFreeTokensFlatButton(
            event: () => const CommercioAccountRequestFreeTokensEvent(),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
            loading: (_) => const Text(
              'Requesting...',
              style: TextStyle(color: Colors.white),
            ),
            child: (_) => const Text(
              'Request free tokens',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestFreeTokensTextField(
              loading: (_) => 'Loading...',
              text: (_, state) => state.accountRequestResponse.isSuccess
                  ? 'Success! Hash: ${state.accountRequestResponse.message}'
                  : 'Error: ${state.accountRequestResponse.message}',
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
