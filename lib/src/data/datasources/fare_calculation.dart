import 'package:nfcmrt/src/app_config/imports/import.dart';

abstract interface class FareCalculation {
  Future<Map<String, dynamic>> getData();
}

class FareCalculationImpl extends FareCalculation {
  @override
  Future<Map<String, dynamic>> getData() async {
    try {
      final List<StationModel> stations = [
        StationModel("Uttara North", 0),
        StationModel("Uttara Center", 1),
        StationModel("Uttara South", 2),
        StationModel("Pallabi", 3),
        StationModel("Mirpur 11", 4),
        StationModel("Mirpur 10", 5),
        StationModel("Kazipara", 6),
        StationModel("Shewrapara", 7),
        StationModel("Agargaon", 8),
        StationModel("Bijoy Sarani", 9),
        StationModel("Farmgate", 10),
        StationModel("Karwan Bazar", 11),
        StationModel("Shahbagh", 12),
        StationModel("Dhaka University", 13),
        StationModel("Bangladesh Secretariat", 14),
        StationModel("Motijheel", 15),
        StationModel("Kamalapur", 16),
      ];

      final Map<String, int> fareMatrix = {
        // Fares from Uttara North (0)
        "0-1": 20, "0-2": 20, "0-3": 30, "0-4": 30, "0-5": 40,
        "0-6": 40, "0-7": 50, "0-8": 60, "0-9": 60, "0-10": 70,
        "0-11": 80, "0-12": 80, "0-13": 90, "0-14": 90, "0-15": 100, "0-16": 100,

        // Fares from Uttara Center (1)
        "1-2": 20, "1-3": 20, "1-4": 30, "1-5": 30, "1-6": 40,
        "1-7": 40, "1-8": 50, "1-9": 60, "1-10": 60, "1-11": 70,
        "1-12": 70, "1-13": 80, "1-14": 90, "1-15": 90, "1-16": 100,

        // Fares from Uttara South (2)
        "2-3": 20, "2-4": 20, "2-5": 30, "2-6": 30, "2-7": 40,
        "2-8": 40, "2-9": 50, "2-10": 60, "2-11": 60, "2-12": 70,
        "2-13": 70, "2-14": 80, "2-15": 90, "2-16": 90,

        // Fares from Pallabi (3)
        "3-4": 20, "3-5": 20, "3-6": 20, "3-7": 30, "3-8": 30,
        "3-9": 40, "3-10": 50, "3-11": 50, "3-12": 60, "3-13": 60,
        "3-14": 70, "3-15": 80, "3-16": 80,

        // Fares from Mirpur 11 (4)
        "4-5": 20, "4-6": 20, "4-7": 20, "4-8": 30, "4-9": 40,
        "4-10": 40, "4-11": 50, "4-12": 60, "4-13": 60, "4-14": 70,
        "4-15": 70, "4-16": 80,

        // Fares from Mirpur 10 (5)
        "5-6": 20, "5-7": 20, "5-8": 20, "5-9": 30, "5-10": 30,
        "5-11": 40, "5-12": 50, "5-13": 50, "5-14": 60, "5-15": 60,
        "5-16": 70,

        // Fares from Kazipara (6)
        "6-7": 20, "6-8": 20, "6-9": 20, "6-10": 30, "6-11": 40,
        "6-12": 40, "6-13": 50, "6-14": 50, "6-15": 60, "6-16": 70,

        // Fares from Shewrapara (7)
        "7-8": 20, "7-9": 20, "7-10": 20, "7-11": 30, "7-12": 40,
        "7-13": 40, "7-14": 50, "7-15": 50, "7-16": 60,

        // Fares from Agargaon (8)
        "8-9": 20, "8-10": 20, "8-11": 20, "8-12": 30, "8-13": 30,
        "8-14": 40, "8-15": 50, "8-16": 50,

        // Fares from Bijoy Sarani (9)
        "9-10": 20, "9-11": 20, "9-12": 20, "9-13": 30, "9-14": 40,
        "9-15": 40, "9-16": 50,

        // Fares from Farmgate (10)
        "10-11": 20, "10-12": 20, "10-13": 20, "10-14": 30, "10-15": 30,
        "10-16": 40,

        // Fares from Karwan Bazar (11)
        "11-12": 20, "11-13": 20, "11-14": 20, "11-15": 30, "11-16": 30,

        // Fares from Shahbagh (12)
        "12-13": 20, "12-14": 20, "12-15": 20, "12-16": 30,

        // Fares from Dhaka University (13)
        "13-14": 20, "13-15": 20, "13-16": 20,

        // Fares from Bangladesh Secretariat (14)
        "14-15": 20, "14-16": 20,

        // Fares from Motijheel (15)
        "15-16": 20,
      };

      // Add symmetrical keys (e.g., "1-0" for "0-1")
      fareMatrix.addAll({
        for (var entry in fareMatrix.entries)
          if (!fareMatrix.containsKey("${entry.key.split('-')[1]}-${entry.key.split('-')[0]}"))
            "${entry.key.split('-')[1]}-${entry.key.split('-')[0]}": entry.value
      });

      // Return stations and fareMatrix as part of the response
      return {
        'stations': stations,
        'fareMatrix': fareMatrix,
      };
    } catch (e) {
      // Improved error handling with better messages and stopping the NFC session safely
      print('Error during data retrieval: $e');
      await NfcManager.instance.stopSession();
      throw Exception('Data fetch failed: ${e.toString()}');
    }
  }
}
