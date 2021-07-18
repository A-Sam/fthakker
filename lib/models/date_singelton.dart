import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class DateSingleton {
  // members
  static final DateSingleton _instance = DateSingleton._();
  DateSingleton._();

  static final DateTime todayGeorgianDate = DateTime.now();
  static final HijriCalendar todayHijriDate = HijriCalendar.now();

  // methods

  factory DateSingleton() {
    return _instance;
  }
}
