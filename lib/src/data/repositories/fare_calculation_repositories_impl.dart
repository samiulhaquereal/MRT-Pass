import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/data/datasources/fare_calculation.dart';
import 'package:nfcmrt/src/domain/repositories/fare_calculation_repositories.dart';

class FareRepositoriesImpl implements FareCalculationRepositories{
  FareRepositoriesImpl({required this.fareCalculation});

  final FareCalculation fareCalculation;

  @override
  Future<Either<Failure, Map<String, dynamic>>> fareInformation()async{
    try{
      Map<String, dynamic> response = await fareCalculation.getData();
      return right(response);
    }catch(e){
      return left(UnknownError(e));
    }
  }
}