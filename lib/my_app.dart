import 'package:nfcmrt/src/app_config/imports/import.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=> SplashBloc(initializeApp: serviceLocator())..add(AppStarted())),
          BlocProvider(create: (context)=> BalanceBloc(transactionInformation: serviceLocator())..add(PageLoaded()))
        ],
        child: SafeArea(
          child: MaterialApp.router(
            title: 'MRT Pass',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router,
          ),
        ),
      ),
    );
  }
}