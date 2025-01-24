abstract class Paths {
  Paths._();
  static const String _splash = "/";
  static const String _dashboardPage = "/dashboardPage";
}

abstract class Routes{
  Routes._();
  static String getSplashRoute ()=> Paths._splash;
  static String getDashboardRoute()=> Paths._dashboardPage;
}