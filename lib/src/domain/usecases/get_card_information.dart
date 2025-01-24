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
            (failure) => Left(failure), // Handle failure from repository
            (success) {
              if (success.isNotEmpty) {
                final entities = success
                    .map((transaction) => TransactionEntity.fromTransaction(transaction))
                    .toList();
                return Right(entities);
              } else {
                return const Left(UnknownError('No transactions found'));
              }
        },
      );
    } catch (e) {
      return Left(UnknownError("Failed to process: ${e.toString()}"));
    }
  }
}
