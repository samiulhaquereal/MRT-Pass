import 'package:nfcmrt/src/app_config/imports/import.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> SplashBloc(initializeApp: serviceLocator())..add(AppStarted())),
        BlocProvider(create: (context)=> DashboardBloc(transactionInformation: serviceLocator())..add(CardScan()))
      ],
      child: MaterialApp.router(
        title: 'MRT Pass',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}