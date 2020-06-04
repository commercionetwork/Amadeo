import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/utils/style.dart';
import 'package:auto_route/auto_route.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sacco/network_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommercioAccountBloc>(
      create: (_) => CommercioAccountBloc(
          commercioAccount: StatefulCommercioAccount(
              networkInfo: NetworkInfo(
        bech32Hrp: 'did:com:',
        lcdUrl: 'http://localhost:1317',
      ))),
      child: MaterialApp(
        title: 'Amadeo',
        theme: companyTheme,
        builder: ExtendedNavigator<Router>(router: Router()),
      ),
    );
  }
}
