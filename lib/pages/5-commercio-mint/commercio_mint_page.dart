import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:commercio_ui/ui/mint/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommercioMintPage extends SectionPageWidget {
  const CommercioMintPage({Key key})
      : super('/5-mint', 'CommercioMintPage', key: key);

  @override
  Widget build(BuildContext context) {
    final commercioAccountBloc = BlocProvider.of<CommercioAccountBloc>(context);

    return BlocProvider<CommercioMintBloc>(
      create: (_) => CommercioMintBloc(
          commercioAccount: commercioAccountBloc.commercioAccount),
      child: BaseScaffoldWidget(bodyWidget: CommercioMintBody()),
    );
  }
}

class CommercioMintBody extends StatelessWidget {
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
                      Navigator.of(context).pushNamed('/5-mint/open-cdp'),
                  child: const Text(
                    '5.1 Opening a Collateral Debt Position',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/5-mint/close-cdp'),
                  child: const Text(
                    '5.2 Closing a Collateral Debt Position',
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
                    '5.3 Check an account CCC balance',
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
                    '5.4 Send a Credit (CCC) to another address',
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
