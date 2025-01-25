import 'package:fpdart/fpdart.dart';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class TransactionInformation implements UseCase<List<TransactionEntity>, NoParams> {
  TransactionInformation({required this.cardRepositories});

  final CardRepositories cardRepositories;

  @override
  Future<Either<Failure, List<TransactionEntity>>> call(NoParams params) async {
    try {
      final response = await cardRepositories.cardInformation();
      return response.fold(
            (failure) => Left(failure),
            (success)  {
              final cardId = success['cardId'] as String?;
              if (cardId == null) {
                return const Left(UnknownError('Missing cardId'));
              }

              if (success.containsKey('transactions') && success['transactions'] is List) {
                final transactions = success['transactions'] as List;

                final entities = transactions
                    .map<TransactionEntity>((transaction) => TransactionEntity.fromTransaction(transaction, cardId))
                    .toList();

                if (entities.isNotEmpty) {
                  return Right(entities);
                } else {
                  return const Left(UnknownError('No transactions found'));
                }
              } else {
                return const Left(UnknownError('Invalid or missing transaction data'));
              }
            },
      );
    } catch (e) {
      return Left(UnknownError("Failed to process: ${e.toString()}"));
    }
  }
}
