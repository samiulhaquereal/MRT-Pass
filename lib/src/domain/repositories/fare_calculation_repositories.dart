import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class FareCalculationRepositories{
  Future<Either<Failure, Map<String, dynamic>>> fareInformation();
}