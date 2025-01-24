import 'package:nfcmrt/src/app_config/imports/import.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MRT Pass',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: _blocListener,
        builder: _blocBuilder,
      ),
    );
  }

  Widget _blocListener(BuildContext context, DashboardState state) {
    return const SizedBox();
  }


  Widget _blocBuilder(BuildContext context, DashboardState state) {
    if (state is DashboardLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is DashboardError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('Retry logic');
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    } else if (state is DashboardLoaded) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                child: Text('Tag Read'),
                onPressed: _tagRead,
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox();
  }
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