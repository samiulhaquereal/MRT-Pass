import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract class FareState extends Equatable {
  const FareState();

  @override
  List<Object?> get props => [];
}

class FareInitial extends FareState {}

class FareLoading extends FareState {}

class FareLoaded extends FareState {
  final List<StationEntities> stations;
  final StationEntities selectedFrom;
  final StationEntities selectedTo;
  final int fare;
  final int? discountedFare;
  final Map<String, int> fareMatrix;

  const FareLoaded({
    required this.stations,
    required this.selectedFrom,
    required this.selectedTo,
    required this.fare,
    required this.fareMatrix,
    this.discountedFare,
  });

  FareLoaded copyWith({
    List<StationEntities>? stations,
    StationEntities? selectedFrom,
    StationEntities? selectedTo,
    int? fare,
    int? discountedFare,
    Map<String, int>? fareMatrix,
  }) {
    return FareLoaded(
      stations: stations ?? this.stations,
      selectedFrom: selectedFrom ?? this.selectedFrom,
      selectedTo: selectedTo ?? this.selectedTo,
      fare: fare ?? this.fare,
      fareMatrix: fareMatrix ?? this.fareMatrix,
      discountedFare: discountedFare ?? this.discountedFare,
    );
  }

  @override
  List<Object?> get props => [stations,selectedFrom,selectedTo,fare,fareMatrix,discountedFare];
}

class FarePageError extends FareState {
  final String message;

  const FarePageError(this.message);

  @override
  List<Object?> get props => [message];
}
