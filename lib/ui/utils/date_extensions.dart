import 'package:intl/intl.dart';

class DateFormats {
  static const String dateFull = 'EEE MMM dd y';
  static const String date = 'MMMM dd';
  static const String dateShort = 'dd.MM.y';
  static const String dayShort = 'dd.MM.y';
  static const String dayTimeShort = 'dd.MM.y HH:mm';
  static const String dateWithYear = "MMM dd, y";
  static const String dayOfWeek = 'EEEE, MMMM d';
  static const String time = 'hh:mm a';
  // ignore: constant_identifier_names
  static const String RFC3339 = "yyyy-MM-dd'T'HH:mm:ss'Z'";
}

extension DateHelper on DateTime {
  String format(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this).replaceAllMapped(
        RegExp(r'(A|P)M'), (match) => match.group(0)!.toLowerCase());
  }

  bool isSameDay(DateTime? other) {
    return year == other?.year && month == other?.month && day == other?.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }

  bool isActive() {
    final now = DateTime.now();
    return isAfter(now);
  }

  String formatDateFull() {
    return format(DateFormats.dateFull);
  }

  String formatDate() {
    return format(DateFormats.date);
  }

  String formatDateShort() {
    return format(DateFormats.dateShort);
  }

  String formatDayShort() {
    return format(DateFormats.dayShort);
  }

  String formatDateTimeShort() {
    return format(DateFormats.dayTimeShort);
  }

  String formatDayOfWeek() {
    return format(DateFormats.dayOfWeek);
  }

  String formatDateWithYear() {
    return format(DateFormats.dateWithYear);
  }

  String formatTime() {
    return format(DateFormats.time);
  }

  String toRFC3339() {
    return format(DateFormats.RFC3339);
  }
}

String formatMinutesToTime(int minutes) {
  final date =
      DateTime.fromMillisecondsSinceEpoch(minutes * 60000, isUtc: true);
  return date.formatTime();
}

String formatMinutes(int minutes) {
  if (minutes < 60) {
    return '$minutes min';
  } else {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (remainingMinutes == 0) {
      return '$hours h';
    } else {
      return '$hours h $remainingMinutes min';
    }
  }
}

Iterable<int> generateSequence(int start, int end, int step) {
  late Iterable<int> sequence;

  if ((start <= end && step > 0) || (start >= end && step < 0)) {
    sequence = Iterable<int>.generate(
      ((end - start) ~/ step).abs() + 1,
      (int index) => start + index * step,
    );
  } else {
    throw ArgumentError('Invalid sequence parameters');
  }

  return sequence;
}
