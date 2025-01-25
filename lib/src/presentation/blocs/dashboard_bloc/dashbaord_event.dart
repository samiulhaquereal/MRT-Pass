import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardEvent extends Equatable{
  @override

  List<Object?> get props => [];

}

class DashboardPageLoaded extends DashboardEvent{}

class DashboardNavigationItemSelected extends DashboardEvent {
  final int index;

  DashboardNavigationItemSelected(this.index);

  @override
  List<Object?> get props => [index];
}