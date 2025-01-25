import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class CardRepositoriesImpl implements CardRepositories{
  CardRepositoriesImpl({required this.cardScanService});

  final CardScanService cardScanService;

  @override
  Future<Either<Failure, List<Transaction>>> cardInformation()async{
    try{
      List<Transaction> response = await cardScanService.scanCard();
      return right(response);
    }catch(e){
      return left(UnknownError(e));
    }
  }
}