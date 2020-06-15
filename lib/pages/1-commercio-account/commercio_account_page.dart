import 'dart:convert';

import 'package:amadeo_flutter/pages/section_page.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommercioAccountPage extends SectionPageWidget {
  const CommercioAccountPage({Key key})
      : super('/1-account', 'CommercioAccountPage', key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(bodyWidget: CommercioAccountBody());
  }
}

class CommercioAccountBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/generate-new-wallet'),
                  child: const Text(
                    '1.1 Generate new wallet',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/restore-wallet-from-mnemonic'),
                  child: const Text(
                    '1.2 Restore wallet from mnemonic',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context).pushNamed(
                      '/1-account/restore-wallet-from-secure-storage'),
                  child: const Text(
                    '1.3 Restore wallet from secure storage',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/share-qr-code'),
                  child: const Text(
                    '1.4 Share QR code',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/request-invite-free-tokens'),
                  child: const Text(
                    '1.5 Request invite and free tokens',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/check-account-balance'),
                  child: const Text(
                    '1.6 Check account balance',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/1-account/send-tokens'),
                  child: const Text(
                    '1.7 Send tokens to another address',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context)
                      .pushNamed('/1-account/generate-many-addresses'),
                  child: const Text(
                    '1.8 Generate many addresses with single mnemonic',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
            'Press the button to request free tokens for the current wallet.',
            padding: EdgeInsets.all(5.0),
          ),
          RequestFreeTokensFlatButton(
            child: () => const Text(
              'Request free tokens',
              style: TextStyle(color: Colors.white),
            ),
            loadingChild: () => const Text(
              'Loading...',
              style: TextStyle(color: Colors.white),
            ),
            color: Theme.of(context).primaryColor,
            disabledColor: Theme.of(context).primaryColorDark,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RequestFreeTokensTextField(
              loadingTextCallback: () => 'Loading...',
              textCallback: (state) => state.accountRequestResponse.isSuccess
                  ? 'Success! Hash: ${state.accountRequestResponse.message}'
                  : 'Error: ${state.accountRequestResponse.message}',
            ),
          ),
        ],
      ),
    );
  }
}
