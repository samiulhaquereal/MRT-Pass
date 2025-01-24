import 'package:nfcmrt/src/app_config/imports/import.dart';


class NavigationHelper {
  NavigationHelper._();

  static void goToSplash(BuildContext context) {
    context.go(Routes.getSplashRoute());
  }

  static void goToDashboard(BuildContext context) {
    context.go(Routes.getDashboardRoute());
  }
}