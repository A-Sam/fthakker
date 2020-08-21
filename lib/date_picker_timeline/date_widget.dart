import 'package:hijri/hijri_calendar.dart';

/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:fthakker/date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fthakker/models/islamic_prayers.dart';

class DateWidget extends StatelessWidget {
  final double width;
  final DateTime date;
  final HijriCalendar hijriDate;
  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;
  final String locale;

  static var currentMonthEnglish =
      DateFormat("MMM").format(DateTime.now()).toUpperCase();

  DateWidget({
    @required this.date,
    this.hijriDate,
    @required this.monthTextStyle,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectionColor,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return GestureDetector(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  new DateFormat("E", locale)
                      .format(date)
                      .toUpperCase(), // WeekDay
                  style: dayTextStyle),
              Text(date.day.toString(), // Date
                  style: dateTextStyle),
              Text(
                  new DateFormat("MMM", locale)
                      .format(date)
                      .toUpperCase(), // Month
                  style: monthTextStyle),
              Column(
                children: <Widget>[
                  Text(
                    islamicPrayersList[0].prayerTime,
                    style: dayTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    islamicPrayersList[1].prayerTime,
                    style: dayTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    islamicPrayersList[2].prayerTime,
                    style: dayTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    islamicPrayersList[3].prayerTime,
                    style: dayTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    islamicPrayersList[4].prayerTime,
                    style: dayTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTapDown: (TapDownDetails details) {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {
          // Call the onDateSelected Function
          onDateSelected(this.date, details);
        }
      },
    );
  }
}
