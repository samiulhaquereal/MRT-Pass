import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardState extends Equatable{
  @override

  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final int currentIndex;

  DashboardLoaded({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}