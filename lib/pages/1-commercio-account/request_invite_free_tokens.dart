import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
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
    return BaseScaffoldWidget(
      bodyWidget: BlocProvider(
        create: (_) => CommercioMembershipBloc(
            commercioAccount: BlocProvider.of<CommercioAccountBloc>(context)
                .commercioAccount),
        child: const RequestInviteFreeTokensPageBody(),
      ),
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
              children: const [
                RequestFaucetInviteWidget(),
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
