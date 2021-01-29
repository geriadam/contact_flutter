import 'constants.dart';
import 'package:intl/intl.dart';
import 'package:contact_flutter/models/log.dart';

bool isValidEmail(String email) {
  return isValid(email, RegularExpressionsPatterns.EMAIL_VALIDATION);
}

bool isValidPhone(String phone) {
  return isValid(phone, RegularExpressionsPatterns.PHONE_VALIDATION);
}

bool isValidLatitude(String latitude) {
  return isValid(latitude, RegularExpressionsPatterns.LATITUDE_PATTERN);
}

bool isValidLongitude(String longitude) {
  return isValid(longitude, RegularExpressionsPatterns.LONGITUDE_PATTERN);
}

bool isValid(String thingNeedToBeValidated, String validationPattern) {
  return new RegExp(validationPattern).hasMatch(thingNeedToBeValidated);
}

String googleMapUrl(String latitude, String longitude) {
  return "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
}

String convertDateFormat(
    String fromDateFormat, String toDateFormat, String toBeConverted) {
  DateFormat fdf = new DateFormat(fromDateFormat);
  DateFormat tdf = new DateFormat(toDateFormat);
  DateTime dateTime = fdf.parse(toBeConverted);
  return tdf.format(dateTime);
}

int giveTimeStamp(String dateFormat, String toBeConverted) {
  DateFormat df = new DateFormat(dateFormat);
  DateTime dateTime = df.parse(toBeConverted);
  return dateTime.millisecondsSinceEpoch;
}

String formatTimeStamp(DateTime timeStamp, String dateFormat) {
  return new DateFormat(dateFormat).format(timeStamp);
}

Log getLog(String transaction) {
  Log log = new Log();
  DateTime dateTime = DateTime.now();
  log.column_timestamp = dateTime.millisecondsSinceEpoch.toString();
  log.column_date = formatTimeStamp(dateTime, LogTableTransactions.DATE_FORMAT);
  log.column_transaction = transaction;
  return log;
}