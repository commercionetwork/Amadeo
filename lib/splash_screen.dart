import 'package:amadeo_flutter/routing/router.gr.dart';
import 'package:amadeo_flutter/widgets/base_scaffold_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  Future _startup(BuildContext context) async {
    return ExtendedNavigator.rootNavigator
        .pushReplacementNamed(Routes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _startup(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const BaseScaffoldWidget(
            bodyWidget: Center(child: CircularProgressIndicator()),
          );
        }

        return null;
      },
    );
  }
}
