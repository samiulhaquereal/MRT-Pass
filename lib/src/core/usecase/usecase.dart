import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}