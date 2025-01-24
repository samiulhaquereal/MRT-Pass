import 'package:nfcmrt/src/app_config/imports/import.dart';

class TransactionParser {
  // Method to check if the transaction is valid
  static bool isValidTransaction(Transaction transaction) {
    final cutoffDate = DateTime(2020, 1, 1, 0, 0);
    return transaction.timestamp.isAfter(cutoffDate);
  }

  // Parse the transaction response from the NFC tag
  static List<Transaction> parseTransactionResponse(Uint8List response) {
    final transactions = <Transaction>[];

    if (response.length < 13) {
      return transactions;
    }

    final statusFlag1 = response[10];
    final statusFlag2 = response[11];

    if (statusFlag1 != 0x00 || statusFlag2 != 0x00) {
      return transactions;
    }

    final numBlocks = response[12] & 0xFF;
    final blockData = response.sublist(13);

    const blockSize = 16;
    if (blockData.length < numBlocks * blockSize) {
      return transactions;
    }

    for (int i = 0; i < numBlocks; i++) {
      final offset = i * blockSize;
      final block = blockData.sublist(offset, offset + blockSize);
      final transaction = parseTransactionBlock(block);
      if (isValidTransaction(transaction)) {
        transactions.add(transaction);
      }
    }

    return transactions;
  }

  // Parse each transaction block
  static Transaction parseTransactionBlock(Uint8List block) {
    if (block.length != 16) {
      throw ArgumentError('Invalid block size');
    }

    final fixedHeader = block.sublist(0, 4);
    final fixedHeaderStr = ByteParser.toHexString(fixedHeader);

    final timestampValue = ByteParser.extractInt24BigEndian(block, 4);
    final transactionTypeBytes = block.sublist(6, 8);
    final transactionType = ByteParser.toHexString(transactionTypeBytes);

    final fromStationCode = ByteParser.extractByte(block, 8);
    final toStationCode = ByteParser.extractByte(block, 10);
    final balance = ByteParser.extractInt24(block, 11);

    final trailingBytes = block.sublist(14, 16);
    final trailing = ByteParser.toHexString(trailingBytes);

    // Convert timestamp value to DateTime (you can implement this based on your format)
    final timestamp = TimestampService.decodeTimestamp(timestampValue);

    // Assuming station names are stored somewhere in your app
    String fromStation = StationService.getStationName(fromStationCode);
    String toStation = StationService.getStationName(toStationCode);
    final fromStationName = StationService.translate(fromStation);  // This should be retrieved from a station list
    final toStationName = StationService.translate(toStation);  // This should be retrieved from a station list
    print(fromStationName);
    print(toStationName);
    return Transaction(
      fixedHeader: fixedHeaderStr,
      timestamp: timestamp,
      transactionType: transactionType,
      fromStation: fromStationName,
      toStation: toStationName,
      balance: balance,
      trailing: trailing,
    );
  }
}