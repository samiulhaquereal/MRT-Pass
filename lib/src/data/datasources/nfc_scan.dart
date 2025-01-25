import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class CardScanService {
  Future<List<Transaction>> scanCard();
}

class CardScanServiceImpl extends CardScanService {

  @override
  Future<List<Transaction>> scanCard() async {
    try {
      List<Transaction> transactions = [];
      // Start the NFC session
      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        // Access the NFC-F specific data
        final nfcF = NfcF.from(tag);
        if (nfcF == null) {
          print("This tag is not an NFC-F tag.");
          NfcManager.instance.stopSession();
          throw Exception("Invalid NFC-F tag.");
        }
        // Extract the IDm (identifier)
        List<int> idm = List<int>.from(tag.data['nfcf']['identifier']);

        // Generate the read command
        NfcCommandGenerator nfcCommandGenerator = NfcCommandGenerator();
        List<int> readCommand = nfcCommandGenerator.generateReadCommand(idm);

        // Use transceive to send the command and receive the response
        final response = await nfcF.transceive(data: Uint8List.fromList(readCommand));
        print('Response from NFC tag: ${ByteParser.toHexString(response)}');

        // Parse the transaction response
        transactions = TransactionParser.parseTransactionResponse(response);
        for (var transaction in transactions) {
          print(transaction);
        }
        // Stop the session after reading the tag
        NfcManager.instance.stopSession();
      });
      return transactions;
    } catch (e) {
      print('Error during tag read: $e');
      NfcManager.instance.stopSession();
      throw UnknownError(e.toString());
    }
  }
}
