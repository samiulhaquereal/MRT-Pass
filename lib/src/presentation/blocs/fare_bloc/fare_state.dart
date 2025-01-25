import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract class FareState extends Equatable {
  const FareState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the fare page is uninitialized
class FareInitial extends FareState {}

/// State when fare data is being loaded
class FareLoading extends FareState {}

/// State when fare data is successfully loaded
class FareLoaded extends FareState {
  final List<StationEntities> stations;
  final StationEntities selectedFrom;
  final StationEntities selectedTo;
  final int fare;
  final Map<String, int> fareMatrix;

  const FareLoaded({
    required this.stations,
    required this.selectedFrom,
    required this.selectedTo,
    required this.fare,
    required this.fareMatrix,
  });

  // A copyWith method to update specific fields without overwriting the entire state
  FareLoaded copyWith({
    List<StationEntities>? stations,
    StationEntities? selectedFrom,
    StationEntities? selectedTo,
    int? fare,
    Map<String, int>? fareMatrix,
  }) {
    return FareLoaded(
      stations: stations ?? this.stations,
      selectedFrom: selectedFrom ?? this.selectedFrom,
      selectedTo: selectedTo ?? this.selectedTo,
      fare: fare ?? this.fare,
      fareMatrix: fareMatrix ?? this.fareMatrix,
    );
  }

  @override
  List<Object?> get props => [stations,selectedFrom,selectedTo,fare,fareMatrix];
}


/// State when an error occurs on the fare page
class FarePageError extends FareState {
  final String message;

  const FarePageError(this.message);

  @override
  List<Object?> get props => [message];
}
