import 'package:nfcmrt/src/app_config/imports/import.dart';

class TransactionEntity {
  final String fixedHeader;
  final DateTime timestamp;
  final String transactionType;
  final String fromStation;
  final String toStation;
  final int balance;
  final String trailing;

  TransactionEntity({
    required this.fixedHeader,
    required this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    required this.trailing,
  });

  /// Factory constructor to create TransactionEntity from a Transaction object
  factory TransactionEntity.fromTransaction(Transaction transaction) {
    return TransactionEntity(
      fixedHeader: transaction.fixedHeader,
      timestamp: transaction.timestamp,
      transactionType: transaction.transactionType,
      fromStation: transaction.fromStation,
      toStation: transaction.toStation,
      balance: transaction.balance,
      trailing: transaction.trailing,
    );
  }

  @override
  String toString() {
    return 'TransactionEntity{fixedHeader: $fixedHeader, timestamp: $timestamp, transactionType: $transactionType, fromStation: $fromStation, toStation: $toStation, balance: $balance, trailing: $trailing}';
  }
}
