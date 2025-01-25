import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class CardRepositories{
  Future<Either<Failure, Map<String, dynamic>>> cardInformation();
}