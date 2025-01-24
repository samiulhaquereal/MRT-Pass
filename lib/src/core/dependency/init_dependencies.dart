import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/data/repositories/card_information_impl.dart';

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
  serviceLocator.registerFactory(() => DashboardBloc(
    transactionInformation: serviceLocator(),
  ));
  serviceLocator.registerFactory(() => SplashBloc(
    initializeApp: serviceLocator(),
  ));

  // Misc
  serviceLocator.registerLazySingleton(() => InitializeApp());
}
