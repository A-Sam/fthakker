import 'package:hijri/hijri_calendar.dart';

/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:fthakker/types.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fthakker/models/prayer_times_cards.dart';

class DateWidget extends StatefulWidget {
  double width;
  final DateTime date;
  final HijriCalendar hijriDate;
  final TextStyle monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final DateSelectionCallback onDateSelected;
  final String locale;
  final Map<String, List> prayTimes;

  static var currentMonthEnglish =
      DateFormat("MMM").format(DateTime.now()).toUpperCase();

  DateWidget({
    @required this.date,
    this.hijriDate,
    @required this.monthTextStyle,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectionColor,
    @required this.prayTimes,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  double itemWidth;
  bool selected = false;

  @override
  void initState() {
    itemWidth = widget.width;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    return Hero(
      tag: widget.date.day,
      child: GestureDetector(
        child: Container(
          width: itemWidth,
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: widget.selectionColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      new DateFormat("E", widget.locale)
                          .format(widget.date)
                          .toUpperCase(), // WeekDay
                      style: widget.dayTextStyle),
                  Text(widget.date.day.toString(), // Date
                      style: widget.dateTextStyle),
                  Text(
                      new DateFormat("MMM", widget.locale)
                          .format(widget.date)
                          .toUpperCase(), // Month
                      style: widget.monthTextStyle),
                  Column(
                    children: <Widget>[
                      Text(
                        widget.prayTimes['fajr'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.prayTimes['sunrise'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.prayTimes['dhuhr'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.prayTimes['asr'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.prayTimes['maghrib'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.prayTimes['isha'][1],
                        style: widget.dayTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onTapDown: (TapDownDetails details) {
          // Check if onDateSelected is not null
          if (widget.onDateSelected != null) {
            // Call the onDateSelected Function
            widget.onDateSelected(this.widget.date, details);
          }
        },
        onDoubleTap: () {
          setState(() {
            selected ^= true;
            // itemWidth += selected ? 100 : -100;
            Navigator.push(
                context,
                MaterialPageRoute(
                    maintainState: false,
                    builder: (context) => DateDetailsPageView(
                          date: widget.date.day,
                        )));
          });
        },
      ),
    );
  }
}

class DateDetailsPageView extends StatelessWidget {
  const DateDetailsPageView({Key key, this.date}) : super(key: key);

  final int date;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: date,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.amber,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
