import 'dart:io';
import 'dart:isolate';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Utility class containing helper methods for formatting, time operations, and parallel processing.
class Utils {
  /// Runs a given synchronous [function] in an isolate to avoid blocking the main thread.
  ///
  /// Returns the result of the function as a Future.
  ///
  /// Example:
  /// ```dart
  /// final result = await Utils.isolator(() => someHeavyComputation());
  /// ```
  static Future<T> isolator<T>(T Function() function) async {
    ReceivePort receivePort = ReceivePort(); // Creates a port to receive data from the isolate.
    await Isolate.spawn((message) {
      T result = function(); // Executes the function.
      Isolate.exit(message as SendPort?, result); // Sends the result back to the main thread.
    }, receivePort.sendPort);
    return await receivePort.first as T; // Returns the result.
  }

  /// Formats a given [date] into a string with the specified [format], defaulting to 'HH:mm'.
  ///
  /// Example:
  /// ```dart
  /// String formattedTime = Utils.formatTimeFromDate(DateTime.now());
  /// print(formattedTime); // Output: 14:30
  /// ```
  static String formatTimeFromDate(DateTime date, {String format = 'HH:mm'}) {
    return DateFormat(format).format(date);
  }

  /// Formats a given [date] into a string with the specified [format], defaulting to 'dd/MM/yyyy'.
  ///
  /// Example:
  /// ```dart
  /// String formattedDate = Utils.formatDate(DateTime.now());
  /// print(formattedDate); // Output: 28/10/2024
  /// ```
  static String formatDate(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  /// Checks if the given [date] is today's date.
  ///
  /// Example:
  /// ```dart
  /// bool isToday = Utils.isToday(DateTime.now());
  /// print(isToday); // Output: true
  /// ```
  static bool isToday(DateTime date) {
    final now = DateTime.now(); // Gets the current date and time.
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Converts a [duration] into a formatted string 'HH:mm:ss'.
  ///
  /// Example:
  /// ```dart
  /// String formattedDuration = Utils.printDuration(Duration(hours: 2, minutes: 5));
  /// print(formattedDuration); // Output: 02:05:00
  /// ```
  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0"); // Ensures two-digit formatting.
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  /// Fetches device information based on the platform (Android or iOS).
  ///
  /// **Returns:** A `Map<String, dynamic>` containing:
  /// - `Brand`: The brand of the device.
  /// - `OS`: The operating system and version.
  /// - `Device_ID`: A unique identifier for the device.
  ///
  /// This function ensures compatibility by checking the platform
  /// and retrieving the correct device information.
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    Map<String, dynamic> body = {};

    if (Platform.isAndroid) {
      /// Get Android-specific device information
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      body = {
        "Brand": androidInfo.brand, // e.g., Samsung, Google
        "OS": "Android ${androidInfo.version.release}", // Android version
        "Device_ID": androidInfo.id // Unique device identifier
      };
    } else if (Platform.isIOS) {
      /// Get iOS-specific device information
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      body = {
        "Brand": "Apple", // iOS devices brand
        "OS": "iOS ${iosInfo.systemVersion}", // iOS version
        "Device_ID": iosInfo.identifierForVendor // Unique device identifier
      };
    } else {
      /// Fallback for unknown platforms
      body = {"Brand": "Unknown", "OS": "Unknown", "Device_ID": "Unknown"};
    }

    return body;
  }

  static Future<bool> isSameDevice(String deviceId) async {
    final deviceInfo = await getDeviceInfo();
    return deviceInfo['Device_ID'] == deviceId;
  }

  static String getAzFormattedDateTime(String date) {
    String dateFormat = 'dd-MMM-yyyy hh:mm:ss';
    // ✅ If input is invalid, return current date in formatted style.
    if (date.length < 12) {
      return formatDate(DateTime.now(), format: dateFormat);
    }

    try {
      // ✅ Extract values from input string
      int day = int.parse(date.substring(0, 2));
      int month = int.parse(date.substring(2, 4));
      int year = DateTime.now().year; // ❗ Default to current year
      int hour = int.parse(date.substring(6, 8));
      int min = int.parse(date.substring(8, 10));
      int secs = int.parse(date.substring(10, 12));

      DateTime parsedDate = DateTime(year, month, day, hour, min, secs);
      return formatDate(parsedDate, format: dateFormat);
    } catch (e) {
      return formatDate(DateTime.now(), format: dateFormat); // Fallback in case of error
    }
  }

  static String formatDateToAzDateTime(DateTime date) {
    return DateFormat('dd-MM-yy-hh-mm-ss', 'en').format(date).replaceAll('-', '');
  }


  /// **Formats a date range from [startDate] to [endDate] using the specified [format].**
  ///
  /// - Defaults to `'dd/MM/yyyy'` if no format is provided.
  /// - If both dates are in the **same month**, it formats as `01-10 Oct 2024`.
  /// - If both dates are in the **same year**, it formats as `01 Oct - 15 Nov 2024`.
  ///
  /// **Examples:**
  /// ```dart
  /// String range1 = Utils.formatDateRange(DateTime(2024, 10, 1), DateTime(2024, 10, 10));
  /// print(range1); // Output: 01-10 Oct 2024
  ///
  /// String range2 = Utils.formatDateRange(DateTime(2024, 10, 1), DateTime(2024, 11, 15));
  /// print(range2); // Output: 01 Oct - 15 Nov 2024
  ///
  /// String range3 = Utils.formatDateRange(DateTime(2023, 10, 1), DateTime(2024, 10, 10));
  /// print(range3); // Output: 01 Oct 2023 - 10 Oct 2024
  /// ```
  static String formatDateRange(DateTime startDate, DateTime endDate, {String format = 'dd M yyyy'}) {
    if (startDate.year == endDate.year) {
      if (startDate.month == endDate.month) {
        return '${DateFormat("dd").format(startDate)}-${DateFormat(format).format(endDate)}';
      }
      return '${DateFormat("dd MMM").format(startDate)} - ${DateFormat(format).format(endDate)}';
    }
    return '${DateFormat(format).format(startDate)} - ${DateFormat(format).format(endDate)}';
  }


  /// **Gets the date range from a number of days ago to today.**
  ///
  /// - Pass the number of days you want to go back from today.
  /// - Returns a [DateTimeRange] starting from `daysBack` days ago at midnight
  ///   to today at 23:59:59.
  ///
  /// **Example:**
  /// ```dart
  /// DateTimeRange range = Utils.getDateRangeFromDaysBack(7);
  /// print(range.start); // Output: 2024-06-09 00:00:00.000
  /// print(range.end);   // Output: 2024-06-16 23:59:59.000
  /// ```
  static DateTimeRange getDateRangeFromDaysBack(int daysBack) {
    final DateTime today = DateTime.now();

    final DateTime start = DateTime(
      today.year,
      today.month,
      today.day - daysBack,
      0, 0, 0,
    );

    final DateTime end = DateTime(
      today.year,
      today.month,
      today.day,
      23, 59, 59,
    );

    return DateTimeRange(start: start, end: end);
  }

  /// **Gets the date range from the most recent Sunday to today.**
  ///
  /// - If today is Sunday, it returns `Sunday - Today`.
  /// - Otherwise, it finds the most recent Sunday and returns the `DateTimeRange`.
  ///
  /// **Example:**
  /// ```dart
  /// DateTimeRange range = Utils.getWeekToTodayRange();
  /// print(range.start); // Output: 2024-02-05 00:00:00.000
  /// print(range.end);   // Output: 2024-02-12 23:59:59.999
  /// ```
  static DateTimeRange getWeekToTodayRange() {
    DateTime today = DateTime.now();
    DateTime sunday = today.subtract(Duration(days: today.weekday % 7));

    // Set start and end times to cover full days
    DateTime startOfSunday = DateTime(sunday.year, sunday.month, sunday.day, 0, 0, 0);
    DateTime endOfToday = DateTime(today.year, today.month, today.day, 23, 59, 59);

    return DateTimeRange(start: startOfSunday, end: endOfToday);
  }

  /// **Gets the date range from the start of the current month to today.**
  ///
  /// - The start date is always the **first day of the current month**.
  /// - The end date is **today**.
  ///
  /// **Example:**
  /// ```dart
  /// DateTimeRange range = Utils.getMonthToTodayRange();
  /// print(range.start); // Output: 2024-02-01 00:00:00.000
  /// print(range.end);   // Output: 2024-02-12 00:00:00.000
  /// ```
  static DateTimeRange getMonthToTodayRange() {
    DateTime today = DateTime.now();
    DateTime startOfMonth = DateTime(today.year, today.month, 1);

    return DateTimeRange(start: startOfMonth, end: today);
  }
}
