import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(DashboardState()) {
    on<DashboardPageLoaded>(_onPageInit);
    on<DashboardNavigationItemSelected>(_onNavigationItemSelected);
  }

  static final List<Widget> navigationPages = [
    BalanceScreen(),
    FareScreen()
  ];

  void _onPageInit(DashboardPageLoaded event, Emitter<DashboardState> emit)async{
    emit(DashboardLoaded(currentIndex: 0));
  }

  void _onNavigationItemSelected(
      DashboardNavigationItemSelected event, Emitter<DashboardState> emit) {
    // Update the current navigation index
    emit(DashboardLoaded(currentIndex: event.index));
  }
}


