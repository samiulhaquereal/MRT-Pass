import 'package:nfcmrt/src/app_config/imports/import.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.vertical,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(border: Border.all()),
                    child: SingleChildScrollView(
                      child: ValueListenableBuilder<dynamic>(
                        valueListenable: result,
                        builder: (context, value, _) =>
                            Text('${value ?? ''}'),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: GridView.count(
                    padding: EdgeInsets.all(4),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: [
                      ElevatedButton(
                        child: Text('Tag Read'),
                        onPressed: _tagRead,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        // Access the NFC-F specific data
        final nfcF = NfcF.from(tag);
        if (nfcF == null) {
          print("This tag is not an NFC-F tag.");
          NfcManager.instance.stopSession();
          return;
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
        List<Transaction> transactions = TransactionParser.parseTransactionResponse(response);

        // Display or process the transactions
        for (var transaction in transactions) {
          print(transaction);
        }
      } catch (e) {
        print('Error during tag read: $e');
      } finally {
        NfcManager.instance.stopSession();
      }
    });
  }

}