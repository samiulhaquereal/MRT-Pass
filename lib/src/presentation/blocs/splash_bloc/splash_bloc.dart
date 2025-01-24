import 'package:nfcmrt/src/app_config/imports/import.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.initializeApp}) : super(const SplashState()) {
    on<AppStarted>(_appStarted);
  }

  final InitializeApp initializeApp;

  void _appStarted(AppStarted event , Emitter<SplashState> emit)async{
    emit(SplashLoading());
    final result = await initializeApp(NoParams());
    result.fold(
          (failure) => emit(SplashError(failure.name)),
          (success) {
        if (success) {
          emit(SplashLoaded());
        } else {
          emit(const SplashError("Splash screen not initialize."));
        }
      },
    );
  }
}