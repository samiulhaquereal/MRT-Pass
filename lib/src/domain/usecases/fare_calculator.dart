import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class FareInformation implements UseCase<Map<String, dynamic>, NoParams> {
  FareInformation({required this.fareCalculationRepositories});

  final FareCalculationRepositories fareCalculationRepositories;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    try {
      final response = await fareCalculationRepositories.fareInformation();

      return response.fold(
            (failure) => Left(failure),
            (success) {
          if (success.containsKey('stations') && success['stations'] is List<dynamic>) {
            return Right(success); // Return both stations and fareMatrix
          } else {
            return const Left(UnknownError('Invalid or missing station data'));
          }
        },
      );
    } catch (e) {
      return Left(UnknownError("Failed to fetch fare information: ${e.toString()}"));
    }
  }
}

