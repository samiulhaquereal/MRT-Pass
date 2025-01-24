import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  final TransactionInformation transactionInformation;

  DashboardBloc({required this.transactionInformation}) : super(DashboardState()) {
    on<CardScan>(_onGetInformation);
  }

  void _onGetInformation(CardScan event, Emitter<DashboardState> emit)async{
    emit(DashboardLoading());
    try {
      final result = await transactionInformation(NoParams());
      result.fold(
            (failure) {
          emit(DashboardError(failure.name));
        },
            (success) {
              print(success);
          // Emit loaded state with the fetched data
          //emit(DashboardLoaded(transactions: transactions));
        },
      );
    } catch (e) {
      // Handle unexpected errors
      emit(DashboardError("Unexpected error occurred: ${e.toString()}"));
    }
  }
}