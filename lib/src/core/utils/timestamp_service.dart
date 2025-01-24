class TimestampService {
  static String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = getMonth(dateTime.month);
    final year = dateTime.year.toString();

    final minutes = dateTime.minute == 0
        ? ":00"
        : ":${dateTime.minute.toString().padLeft(2, '0')}";

    return "$day $month $year, ${getHour(dateTime.hour)}$minutes ${getAmPm(dateTime.hour)}";
  }

  static String getAmPm(int hour) {
    return hour < 12 ? "AM" : "PM";
  }

  static String getHour(int hour) {
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return hour12.toString().padLeft(2, '0');
  }

  static String getMonth(int month) {
    switch (month) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "Mar";
      case 4: return "Apr";
      case 5: return "May";
      case 6: return "Jun";
      case 7: return "Jul";
      case 8: return "Aug";
      case 9: return "Sep";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
      default: return "Unknown";
    }
  }

  static DateTime decodeTimestamp(int value) {
    final hour = (value >> 3) & 0x1F;
    final day = (value >> 8) & 0x1F;
    final month = (value >> 13) & 0x0F;
    final year = (value >> 17) & 0x1F;

    final fullYear = getBaseYear() + year;
    final validMonth = (month >= 1 && month <= 12) ? month : 1;
    final validDay = (day >= 1 && day <= 31) ? day : 1;

    return DateTime(fullYear, validMonth, validDay, hour);
  }

  static int getBaseYear() {
    final currentYear = DateTime.now().year;
    return currentYear - (currentYear % 100);
  }
}
