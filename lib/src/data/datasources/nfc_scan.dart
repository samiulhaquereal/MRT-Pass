import 'dart:developer';
import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class CardScanService {
  Future<Map<String, dynamic>> scanCard();
}

class CardScanServiceImpl extends CardScanService {
  @override
  Future<Map<String, dynamic>> scanCard() async {
    final completer = Completer<Map<String, dynamic>>();

    try {
      List<Transaction> transactions = [];

      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        try {
          final nfcF = NfcF.from(tag);
          if (nfcF == null) {
            log("This tag is not an NFC-F tag.");
            NfcManager.instance.stopSession();
            throw Exception("Invalid NFC-F tag.");
          }
          // Extract the IDm (identifier)
          List<int> idm = List<int>.from(tag.data['nfcf']['identifier']);
          String cardId = ByteParser.toHexString(Uint8List.fromList(idm));
          print(cardId);

          NfcCommandGenerator nfcCommandGenerator = NfcCommandGenerator();
          List<int> readCommand = nfcCommandGenerator.generateReadCommand(idm);

          final response = await nfcF.transceive(data: Uint8List.fromList(readCommand));

          transactions = TransactionParser.parseTransactionResponse(response);
          //completer.complete(transactions);
          completer.complete({
            'cardId': cardId,
            'transactions': transactions,
          });
          NfcManager.instance.stopSession();
        } catch (e) {
          log('Error during tag read: $e');
          completer.completeError(e);
          NfcManager.instance.stopSession();
        }
      });
      return completer.future;
    } catch (e) {
      log('Error during NFC session: $e');
      NfcManager.instance.stopSession();
      throw UnknownError(e.toString());
    }
  }
}
