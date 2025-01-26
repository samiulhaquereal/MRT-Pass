class StationService {
  static const stationMap = {
    10: "Motijheel",
    20: "Bangladesh Secretariat",
    25: "Dhaka University",
    30: "Shahbagh",
    35: "Karwan Bazar",
    40: "Farmgate",
    45: "Bijoy Sarani",
    50: "Agargaon",
    55: "Shewrapara",
    60: "Kazipara",
    65: "Mirpur 10",
    70: "Mirpur 11",
    75: "Pallabi",
    80: "Uttara South",
    85: "Uttara Center",
    90: "Uttara North",
  };

  static String getStationName(int code) {
    return stationMap[code] ?? "Unknown Station ($code)";
  }

  static String translate(String stationName) {
    switch (stationName) {
      case "Motijheel": return "Motijheel (Localized)";
      case "Bangladesh Secretariat": return "Bangladesh Secretariat (Localized)";
      case "Dhaka University": return "Dhaka University (Localized)";
      default: return stationName;
    }
  }
}
