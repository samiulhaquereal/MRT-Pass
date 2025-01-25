import 'package:nfcmrt/src/app_config/imports/import.dart';

class StationEntities {
  final String name;
  final int id;

  StationEntities({required this.name, required this.id});

  factory StationEntities.fromStationModel(StationModel model) {
    return StationEntities(
      name: model.name,
      id: model.id,
    );
  }
}
