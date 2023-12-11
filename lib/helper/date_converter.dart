import 'package:intl/intl.dart';

class DateConverter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  static String estimatedDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  static DateTime convertStringToDatetime(String dateTime) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(dateTime);
  }
  static String dateStringMonthYear(DateTime ? dateTime) {
    return DateFormat('d MMM,y').format(dateTime!);
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime).toLocal();
  }
  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
  }

  static String localDateToIsoStringAMPMOrder(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, h:mm a ').format(dateTime.toLocal());
  }

  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd:MM:yy').format(isoStringToLocalDate(dateTime));
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime.toLocal());
  }

  static String isoStringToLocalDateAndTime(String dateTime) {
    return DateFormat('dd-MMM-yyyy hh:mm a').format(isoStringToLocalDate(dateTime));
  }

  static String dateFormatForWalletBonus(String dateTime) {
    return DateFormat('dd MMM, yyyy').format(isoStringToLocalDate(dateTime));
  }
  static String dateTimeStringToDateTime(String dateTime) {
    return DateFormat('dd MMM, yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }

  static String dateTimeStringToDateAndTime(String dateTime) {
    return DateFormat('hh:mm a, dd MMM yyyy').format(DateFormat('yyyy-MM-ddTHH:mm:ss').parse(dateTime));
  }
  static String estimatedDateYear(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String customTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now';
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return 'yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {

      String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      return weekday;
    }

    return localDateToIsoStringAMPM(dateTime);
  }

}
