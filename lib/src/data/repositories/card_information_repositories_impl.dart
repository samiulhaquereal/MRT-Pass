import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class CardRepositoriesImpl implements CardRepositories{
  CardRepositoriesImpl({required this.cardScanService});

  final CardScanService cardScanService;

  @override
  Future<Either<Failure, Map<String, dynamic>>> cardInformation()async{
    try{
      Map<String, dynamic> response = await cardScanService.scanCard();
      return right(response);
    }catch(e){
      return left(UnknownError(e));
    }
  }
}