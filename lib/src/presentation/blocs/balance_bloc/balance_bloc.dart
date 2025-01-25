import 'package:nfcmrt/src/app_config/imports/import.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {

  final TransactionInformation transactionInformation;

  BalanceBloc({required this.transactionInformation}) : super(BalanceState()) {
    on<PageLoaded>(_onPageInit);
    on<CardScan>(_onGetInformation);
  }



  void _onPageInit(PageLoaded event, Emitter<BalanceState> emit)async{
    emit(BalanceLoaded());
  }

  void _onGetInformation(CardScan event, Emitter<BalanceState> emit)async{
    emit(BalanceLoading());
    try {
      final result = await transactionInformation(NoParams());
      result.fold(
            (failure) {
          emit(BalanceError(failure.name));
        },
            (success) {
              print(success);
          // Emit loaded state with the fetched data
          //emit(BalanceLoaded(transactions: transactions));
        },
      );
    } catch (e) {
      // Handle unexpected errors
      emit(BalanceError("Unexpected error occurred: ${e.toString()}"));
    }
  }
}