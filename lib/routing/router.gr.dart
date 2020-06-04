// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:amadeo_flutter/splash_screen.dart';
import 'package:amadeo_flutter/home_screen.dart';
import 'package:amadeo_flutter/pages/1-commercio-account/commercio_account_page.dart';
import 'package:amadeo_flutter/pages/2-commercio-id/commercio_id_page.dart';
import 'package:amadeo_flutter/pages/3-commercio-docs/commercio_docs_page.dart';
import 'package:amadeo_flutter/pages/5-commercio-mint/commercio_mint_page.dart';
import 'package:amadeo_flutter/pages/6-commercio-membership/commercio_membership_page.dart';

abstract class Routes {
  static const splashScreen = '/';
  static const homeScreen = '/home-screen';
  static const commercioAccountPage = '/commercio-account-page';
  static const commercioIdPage = '/commercio-id-page';
  static const commercioDocsPage = '/commercio-docs-page';
  static const commercioMintPage = '/commercio-mint-page';
  static const commercioMembershipPage = '/commercio-membership-page';
  static const all = {
    splashScreen,
    homeScreen,
    commercioAccountPage,
    commercioIdPage,
    commercioDocsPage,
    commercioMintPage,
    commercioMembershipPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case Routes.homeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
      case Routes.commercioAccountPage:
        if (hasInvalidArgs<CommercioAccountPageArguments>(args)) {
          return misTypedArgsRoute<CommercioAccountPageArguments>(args);
        }
        final typedArgs = args as CommercioAccountPageArguments ??
            CommercioAccountPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommercioAccountPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.commercioIdPage:
        if (hasInvalidArgs<CommercioIdPageArguments>(args)) {
          return misTypedArgsRoute<CommercioIdPageArguments>(args);
        }
        final typedArgs =
            args as CommercioIdPageArguments ?? CommercioIdPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommercioIdPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.commercioDocsPage:
        if (hasInvalidArgs<CommercioDocsPageArguments>(args)) {
          return misTypedArgsRoute<CommercioDocsPageArguments>(args);
        }
        final typedArgs =
            args as CommercioDocsPageArguments ?? CommercioDocsPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommercioDocsPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.commercioMintPage:
        if (hasInvalidArgs<CommercioMintPageArguments>(args)) {
          return misTypedArgsRoute<CommercioMintPageArguments>(args);
        }
        final typedArgs =
            args as CommercioMintPageArguments ?? CommercioMintPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommercioMintPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.commercioMembershipPage:
        if (hasInvalidArgs<CommercioMembershipPageArguments>(args)) {
          return misTypedArgsRoute<CommercioMembershipPageArguments>(args);
        }
        final typedArgs = args as CommercioMembershipPageArguments ??
            CommercioMembershipPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CommercioMembershipPage(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//CommercioAccountPage arguments holder class
class CommercioAccountPageArguments {
  final Key key;
  CommercioAccountPageArguments({this.key});
}

//CommercioIdPage arguments holder class
class CommercioIdPageArguments {
  final Key key;
  CommercioIdPageArguments({this.key});
}

//CommercioDocsPage arguments holder class
class CommercioDocsPageArguments {
  final Key key;
  CommercioDocsPageArguments({this.key});
}

//CommercioMintPage arguments holder class
class CommercioMintPageArguments {
  final Key key;
  CommercioMintPageArguments({this.key});
}

//CommercioMembershipPage arguments holder class
class CommercioMembershipPageArguments {
  final Key key;
  CommercioMembershipPageArguments({this.key});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension RouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushSplashScreen() => pushNamed(Routes.splashScreen);

  Future pushHomeScreen() => pushNamed(Routes.homeScreen);

  Future pushCommercioAccountPage({
    Key key,
  }) =>
      pushNamed(
        Routes.commercioAccountPage,
        arguments: CommercioAccountPageArguments(key: key),
      );

  Future pushCommercioIdPage({
    Key key,
  }) =>
      pushNamed(
        Routes.commercioIdPage,
        arguments: CommercioIdPageArguments(key: key),
      );

  Future pushCommercioDocsPage({
    Key key,
  }) =>
      pushNamed(
        Routes.commercioDocsPage,
        arguments: CommercioDocsPageArguments(key: key),
      );

  Future pushCommercioMintPage({
    Key key,
  }) =>
      pushNamed(
        Routes.commercioMintPage,
        arguments: CommercioMintPageArguments(key: key),
      );

  Future pushCommercioMembershipPage({
    Key key,
  }) =>
      pushNamed(
        Routes.commercioMembershipPage,
        arguments: CommercioMembershipPageArguments(key: key),
      );
}
