import 'package:nfcmrt/src/app_config/imports/import.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton(() => TransactionInformation(
    cardRepositories: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton<CardRepositories>(() => CardRepositoriesImpl(
    cardScanService: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton<CardScanService>(() => CardScanServiceImpl());
  serviceLocator.registerFactory(() => BalanceBloc(
    transactionInformation: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => SplashBloc(
    initializeApp: serviceLocator(),
  ));
  serviceLocator.registerLazySingleton(() => InitializeApp());
  serviceLocator.registerLazySingleton<FareCalculation>(() => FareCalculationImpl());
  serviceLocator.registerLazySingleton<FareCalculationRepositories>(
        () => FareRepositoriesImpl(
      fareCalculation: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(() => FareInformation(
    fareCalculationRepositories: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => FareBloc(
    fareInformation: serviceLocator(),
  ));
}
