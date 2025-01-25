import 'package:nfcmrt/src/app_config/imports/import.dart';

class AppRouter {
  AppRouter._();
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.getSplashRoute(),
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.getDashboardRoute(),
        builder: (context, state) => BalanceScreen(),
      ),
    ],
  );
}