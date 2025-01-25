class Transaction {
  String fixedHeader;
  DateTime timestamp;
  String? dateTime;
  String transactionType;
  String fromStation;
  String toStation;
  int balance;
  String trailing;

  Transaction({
    required this.fixedHeader,
    required this.timestamp,
    required this.transactionType,
    required this.fromStation,
    required this.toStation,
    required this.balance,
    required this.trailing,
    this.dateTime,
  });

  @override
  String toString() {
    return 'Transaction{fixedHeader: $fixedHeader, timestamp: $dateTime, transactionType: $transactionType, fromStation: $fromStation, toStation: $toStation, balance: $balance, trailing: $trailing}';
  }
}
