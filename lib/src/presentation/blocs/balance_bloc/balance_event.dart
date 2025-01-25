import 'package:nfcmrt/src/app_config/imports/import.dart';

class BalanceEvent extends Equatable{
  @override

  List<Object?> get props => [];

}

class PageLoaded extends BalanceEvent{}

class CardScan extends BalanceEvent{}