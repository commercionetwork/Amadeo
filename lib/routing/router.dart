import 'package:auto_route/auto_route_annotations.dart';

import 'package:amadeo_flutter/home_screen.dart';
import 'package:amadeo_flutter/pages/export.dart';
import 'package:amadeo_flutter/splash_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  generateArgsHolderForSingleParameterRoutes: true,
  routesClassName: 'Routes',
)
class $Router {
  @initial
  SplashScreen splashScreen;

  HomeScreen homeScreen;

  // Section pages
  CommercioAccountPage commercioAccountPage;
  CommercioIdPage commercioIdPage;
  CommercioDocsPage commercioDocsPage;
  CommercioMintPage commercioMintPage;
  CommercioMembershipPage commercioMembershipPage;
}
