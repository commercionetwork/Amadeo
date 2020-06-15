import 'dart:convert';

import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:amadeo_flutter/widgets/paragraph_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/account/bloc/commercio_account_bloc.dart';
import 'package:commercio_ui/ui/membership/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacco/wallet.dart';

class CommercioKYCPage extends SectionPageWidget {
  const CommercioKYCPage({Key key})
      : super('/6-kyc', 'CommercioKYCPage', key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioMembershipBloc>(
      create: (_) => CommercioMembershipBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioKYCPageBody()),
    );
  }
}

class CommercioKYCPageBody extends StatelessWidget {
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
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/6-kyc/buy-membership'),
                  child: const Text(
                    '6.1 Buy a membership with Cash Coins',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/6-kyc/invite-member'),
                  child: const Text(
                    '6.2 Invite a Member',
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
