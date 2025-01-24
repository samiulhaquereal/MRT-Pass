import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<DashboardGetBangladeshInformation>(_onGetBangladeshInformation);
  }

  void _onGetBangladeshInformation(DashboardGetBangladeshInformation event, Emitter<DashboardState> emit)async{
    emit(DashboardLoading());
  }
}