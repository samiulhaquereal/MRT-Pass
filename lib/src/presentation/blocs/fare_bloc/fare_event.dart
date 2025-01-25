import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract class FareEvent extends Equatable {
  const FareEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when the fare page is loaded
class FarePageLoaded extends FareEvent {}

/// Event triggered when the user selects different stations
class StationSelectionChanged extends FareEvent {
  final StationEntities? selectedFrom;
  final StationEntities? selectedTo;

  const StationSelectionChanged({
    this.selectedFrom,
    this.selectedTo,
  });

  @override
  List<Object?> get props => [selectedFrom, selectedTo];
}
