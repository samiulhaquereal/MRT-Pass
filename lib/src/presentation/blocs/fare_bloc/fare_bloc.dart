import 'dart:developer';
import 'package:nfcmrt/src/app_config/imports/import.dart';

class FareBloc extends Bloc<FareEvent, FareState> {
  FareBloc({required this.fareInformation}) : super(FareInitial()) {
    on<FarePageLoaded>(_onPageInit);
    on<StationSelectionChanged>(_onStationSelectionChanged);
  }

  final FareInformation fareInformation;
  int discountedFare = 0 ;

  void _onPageInit(FarePageLoaded event, Emitter<FareState> emit) async {
    emit(FareLoading());

    final result = await fareInformation(NoParams());
    result.fold(
          (failure) {
        emit(FarePageError(failure.name));
      },
          (success) {
        final stations = (success['stations'] as List<StationModel>)
            .map((station) => StationEntities.fromStationModel(station))
            .toList();
        final fareMatrix = success['fareMatrix'] as Map<String, int>;

        emit(FareLoaded(
          stations: stations,
          selectedFrom: stations.first,
          selectedTo: stations[1],
          fare: 0,
          fareMatrix: fareMatrix, // Pass the fareMatrix to the state
        ));
        log("Initial State: From ${stations.first.name}, To ${stations[1].name}");
      },
    );
  }

  void _onStationSelectionChanged(StationSelectionChanged event, Emitter<FareState> emit) {
    if (state is FareLoaded) {
      final currentState = state as FareLoaded;

      final newSelectedFrom = event.selectedFrom ?? currentState.selectedFrom;
      final newSelectedTo = event.selectedTo ?? currentState.selectedTo;

      final fare = calculateFare(
        newSelectedFrom,
        newSelectedTo,
        currentState.fareMatrix,
      );

      discountedFare = (fare * 0.9).toInt();

      emit(currentState.copyWith(
        selectedFrom: newSelectedFrom,
        selectedTo: newSelectedTo,
        fare: fare,
        discountedFare: discountedFare,
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

    return fareMatrix[key] ?? fareMatrix[reverseKey] ?? 0;
  }
}
