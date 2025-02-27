import 'package:nfcmrt/src/app_config/imports/import.dart';

class BalanceState extends Equatable{
  @override

  List<Object?> get props => [];
}

class BalanceInitial extends BalanceState {}

class WaitingForScan extends BalanceState {}

class BalanceLoading extends BalanceState {}

class BalanceLoaded extends BalanceState {
  BalanceLoaded({this.transactions = const []});

  final List<TransactionEntity> transactions;

  @override
  List<Object?> get props => [transactions];
}

class BalanceError extends BalanceState {
  final String message;
  BalanceError(this.message);

  @override
  List<Object?> get props => [message];
}