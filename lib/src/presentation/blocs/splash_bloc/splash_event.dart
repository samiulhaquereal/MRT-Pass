import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract class SplashEvent extends Equatable{
  const SplashEvent();

  List<Object?> get props => [];
}

class AppStarted extends SplashEvent{}