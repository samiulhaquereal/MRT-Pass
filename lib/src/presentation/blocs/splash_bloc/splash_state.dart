import 'package:nfcmrt/src/app_config/imports/import.dart';

class SplashState extends Equatable{
  const SplashState();

  @override
  List<Object?> get props => [];

}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
}