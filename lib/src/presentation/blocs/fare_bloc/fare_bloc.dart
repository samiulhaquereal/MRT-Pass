import 'package:nfcmrt/src/app_config/imports/import.dart';
import 'package:nfcmrt/src/domain/usecases/fare_calculator.dart';

class FareBloc extends Bloc<FareEvent, FareState> {
  FareBloc({required this.fareInformation}) : super(FareInitial()) {
    on<FarePageLoaded>(_onPageInit);
    on<StationSelectionChanged>(_onStationSelectionChanged);
  }

  final FareInformation fareInformation;

  void _onPageInit(FarePageLoaded event, Emitter<FareState> emit) async {
    emit(FareLoading());

    final result = await fareInformation(NoParams());
    result.fold(
          (failure) {
        emit(FarePageError(failure.name));
      },
          (success) {
        // Extract stations and fareMatrix from the response
        final stations = (success['stations'] as List<StationModel>)
            .map((station) => StationEntities.fromStationModel(station))
            .toList();
        final fareMatrix = success['fareMatrix'] as Map<String, int>;


        print('Real');
        emit(FareLoaded(
          stations: stations,
          selectedFrom: stations.first,
          selectedTo: stations[1],
          fare: 0,
          fareMatrix: fareMatrix, // Pass the fareMatrix to the state
        ));
        print("Initial State: From ${stations.first.name}, To ${stations[1].name}");
      },
    );
  }

  void _onStationSelectionChanged(StationSelectionChanged event, Emitter<FareState> emit) {
    if (state is FareLoaded) {
      final currentState = state as FareLoaded;

      // Only update the selected station that was changed
      print(event.selectedFrom?.name);
      print(event.selectedTo?.name);
      final newSelectedFrom = event.selectedFrom ?? currentState.selectedFrom;
      final newSelectedTo = event.selectedTo ?? currentState.selectedTo;

      // Calculate the fare with the selected stations
      final fare = calculateFare(
        newSelectedFrom,
        newSelectedTo,
        currentState.fareMatrix,
      );

      print("currentState From: ${currentState.selectedFrom.name}");
      print("Selected From: ${newSelectedFrom.name}");
      print("currentState To: ${currentState.selectedTo.name}");
      print("Selected To: ${newSelectedTo.name}");
      print("Calculated Fare: $fare");

      // Emit the updated state with the correct selected stations and the calculated fare
      emit(currentState.copyWith(
        selectedFrom: newSelectedFrom,
        selectedTo: newSelectedTo,
        fare: fare,
      ));
    }
  }






  int calculateFare(
      StationEntities from,
      StationEntities to,
      Map<String, int> fareMatrix,
      ) {
    if (from.id == to.id) return 0;

    final String key = "${from.id}-${to.id}";
    final String reverseKey = "${to.id}-${from.id}";

    // Return fare or default to 0 if not found
    return fareMatrix[key] ?? fareMatrix[reverseKey] ?? 0;
  }


}
