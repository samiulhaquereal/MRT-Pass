import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract class FareEvent extends Equatable {
  const FareEvent();

  @override
  List<Object?> get props => [];
}

class FarePageLoaded extends FareEvent {}

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
