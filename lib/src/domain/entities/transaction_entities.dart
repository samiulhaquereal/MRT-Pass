import 'package:nfcmrt/src/app_config/imports/import.dart';

class TransactionEntity {
  final String cardId;
  final String fixedHeader;
  final String? timestamp;
  final String transactionType;
  final String fromStation;
  final String toStation;
  final int balance;
  final String trailing;

  TransactionEntity({
    required this.fixedHeader,
    required this.cardId,
    this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    required this.trailing,
  });

  factory TransactionEntity.fromTransaction(Transaction transaction, String cardId) {
    return TransactionEntity(
      cardId: cardId,
      fixedHeader: transaction.fixedHeader,
      timestamp: transaction.dateTime ,
      transactionType: transaction.transactionType,
      fromStation: transaction.fromStation,
      toStation: transaction.toStation,
      balance: transaction.balance,
      trailing: transaction.trailing,
    );
  }

  @override
  String toString() {
    return 'TransactionEntity{cardId: $cardId,fixedHeader: $fixedHeader, timestamp: $timestamp, transactionType: $transactionType, fromStation: $fromStation, toStation: $toStation, balance: $balance, trailing: $trailing}';
  }
}
