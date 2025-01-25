import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/data/datasources/fare_calculation.dart';
import 'package:nfcmrt/src/data/repositories/card_information_repositories_impl.dart';
import 'package:nfcmrt/src/data/repositories/fare_calculation_repositories_impl.dart';
import 'package:nfcmrt/src/domain/usecases/fare_calculator.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  // Use Cases
  serviceLocator.registerLazySingleton(() => TransactionInformation(
    cardRepositories: serviceLocator(),
  ));

  // Repositories
  serviceLocator.registerLazySingleton<CardRepositories>(() => CardRepositoriesImpl(
    cardScanService: serviceLocator(),
  ));

  // Services
  serviceLocator.registerLazySingleton<CardScanService>(() => CardScanServiceImpl());

  // Blocs
  serviceLocator.registerFactory(() => BalanceBloc(
    transactionInformation: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => SplashBloc(
    initializeApp: serviceLocator(),
  ));

  // Misc
  serviceLocator.registerLazySingleton(() => InitializeApp());

  // Data Layer - FareCalculation Implementation
  serviceLocator.registerLazySingleton<FareCalculation>(() => FareCalculationImpl());

  // Repository Layer - FareCalculationRepository Implementation
  serviceLocator.registerLazySingleton<FareCalculationRepositories>(
        () => FareRepositoriesImpl(
      fareCalculation: serviceLocator(),
    ),
  );

  // Domain Layer - Use Case for Fare Information
  serviceLocator.registerLazySingleton(() => FareInformation(
    fareCalculationRepositories: serviceLocator(),
  ));

  // Bloc Layer - FareBloc
  serviceLocator.registerFactory(() => FareBloc(
    fareInformation: serviceLocator(),
  ));
}
