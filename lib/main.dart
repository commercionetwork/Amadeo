import 'package:amadeo_flutter/home_screen.dart';
import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/utils/style.dart';
import 'package:commercio_ui/commercio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommercioAccountBloc>(
      create: (_) =>
          CommercioAccountBloc(commercioAccount: StatefulCommercioAccount()),
      child: MaterialApp(
        title: 'Amadeo',
        theme: companyTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/1-account': (context) => const CommercioAccountPage(),
          '/2-id': (context) => const CommercioIdPage(),
          '/3-docs': (context) => const CommercioDocsPage(),
          '/4-sign': (context) => const CommercioSignPage(),
          '/5-mint': (context) => const CommercioMintPage(),
          '/6-membership': (context) => const CommercioMembershipPage(),
        },
      ),
    );
  }
}
