import 'package:hijri/hijri_calendar.dart';
import 'package:thakker/date_picker_timeline/date_widget.dart';
import 'package:thakker/date_picker_timeline/extra/color.dart';
import 'package:thakker/date_picker_timeline/extra/style.dart';
import 'package:thakker/date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:thakker/size_config.dart';

class DatePicker extends StatefulWidget {
  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;
  final DateTime endDate;
  final HijriCalendar hijriDate;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController controller;

  /// Text color for the selected Date
  final Color selectedTextColor;

  /// Background color for the selector
  final Color selectionColor;

  /// Text Color for the deactivated dates
  final Color deactivatedColor;

  /// TextStyle for Month Value
  final TextStyle monthTextStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime> inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime> activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  DateTime currentDate;

  TapDownDetails latestTapDetails;

  DatePicker(this.startDate,
      {Key key,
      this.width = 80,
      this.height = 180,
      this.controller,
      this.monthTextStyle = defaultMonthTextStyle,
      this.dayTextStyle = defaultDayTextStyle,
      this.dateTextStyle = defaultDateTextStyle,
      this.selectedTextColor = Colors.white,
      this.selectionColor = AppColors.defaultSelectionColor,
      this.deactivatedColor = AppColors.defaultDeactivatedColor,
      this.initialSelectedDate,
      this.activeDates,
      this.inactiveDates,
      this.daysCount = 10,
      this.onDateChange,
      this.locale = "en_US",
      this.currentDate,
      this.latestTapDetails,
      this.endDate,
      this.hijriDate})
      : assert(
            activeDates == null || inactiveDates == null,
            "Can't "
            "provide both activated and deactivated dates List at the same time.");

  @override
  State<StatefulWidget> createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _currentDate;

  ScrollController _controller = ScrollController();

  TextStyle selectedDateStyle;
  TextStyle selectedMonthStyle;
  TextStyle selectedDayStyle;

  TextStyle deactivatedDateStyle;
  TextStyle deactivatedMonthStyle;
  TextStyle deactivatedDayStyle;

  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);
    // Set initial Values
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller.setDatePickerState(this);
    }

    HijriCalendar.setLocal(widget.locale);

    this.selectedDateStyle =
        createTextStyle(widget.dateTextStyle, widget.selectedTextColor);
    this.selectedMonthStyle =
        createTextStyle(widget.monthTextStyle, widget.selectedTextColor);
    this.selectedDayStyle =
        createTextStyle(widget.dayTextStyle, widget.selectedTextColor);

    this.deactivatedDateStyle =
        createTextStyle(widget.dateTextStyle, widget.deactivatedColor);
    this.deactivatedMonthStyle =
        createTextStyle(widget.monthTextStyle, widget.deactivatedColor);
    this.deactivatedDayStyle =
        createTextStyle(widget.dayTextStyle, widget.deactivatedColor);

    super.initState();
  }

  /// This will return a text style for the Selected date Text Values
  /// the only change will be the color provided
  TextStyle createTextStyle(TextStyle style, Color color) {
    if (color != null) {
      return TextStyle(
        color: color,
        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        fontFamily: style.fontFamily,
        letterSpacing: style.letterSpacing,
      );
    } else {
      return style;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        reverse: true,
        itemBuilder: (context, index) {
          // get the date object based on the index position
          // if widget.startDate is null then use the initialDateValue
          DateTime _date = widget.startDate.add(Duration(days: index));
          DateTime date = new DateTime(_date.year, _date.month, _date.day);

          bool isDeactivated = false;

          // check if this date needs to be deactivated for only DeactivatedDates
          if (widget.inactiveDates != null) {
//            print("Inside Inactive dates.");
            for (DateTime inactiveDate in widget.inactiveDates) {
              if (_compareDate(date, inactiveDate)) {
                isDeactivated = true;
                break;
              }
            }
          }

          // check if this date needs to be deactivated for only ActivatedDates
          if (widget.activeDates != null) {
            isDeactivated = true;
            for (DateTime activateDate in widget.activeDates) {
              // Compare the date if it is in the
              if (_compareDate(date, activateDate)) {
                isDeactivated = false;
                break;
              }
            }
          }

          // Check if this date is the one that is currently selected
          bool isSelected =
              _currentDate != null ? _compareDate(date, _currentDate) : false;

          // Return the Date Widget
          return DateWidget(
            date: date,
            monthTextStyle: isDeactivated
                ? deactivatedMonthStyle
                : isSelected ? selectedMonthStyle : widget.monthTextStyle,
            dateTextStyle: isDeactivated
                ? deactivatedDateStyle
                : isSelected ? selectedDateStyle : widget.dateTextStyle,
            dayTextStyle: isDeactivated
                ? deactivatedDayStyle
                : isSelected ? selectedDayStyle : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor:
                isSelected ? widget.selectionColor : Colors.transparent,
            onDateSelected: (selectedDate, details) {
              // Don't notify listener if date is deactivated
              if (isDeactivated) return;

              // A date is selected
              setState(() {
                _currentDate = selectedDate;
                widget.currentDate = selectedDate;
                widget.latestTapDetails = details;
              });
              if (widget.onDateChange != null) {
                widget.onDateChange(selectedDate);
              }
            },
            // hijriDate: widget.hijriDate,
          );
        },
      ),
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _DatePickerState _datePickerState;
  double oneDateWidth;

  void setDatePickerState(_DatePickerState state) {
    _datePickerState = state;
    oneDateWidth = _datePickerState.widget.width;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState._controller.jumpTo(
        _datePickerState._currentDate.day * oneDateWidth - oneDateWidth);
    // .jumpTo(_calculateDateOffset(_datePickerState._currentDate));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection(
      {duration = const Duration(milliseconds: 1000),
      curve = Curves.fastOutSlowIn}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // animate to the current date
    _datePickerState._controller.animateTo(
        _datePickerState._currentDate.day * oneDateWidth - oneDateWidth,
        // _calculateDateOffset(_datePickerState._currentDate),
        duration: duration,
        curve: curve);
  }

  /// This function will animate to any date that is passed as a parameter
  /// In case a date is out of range nothing will happen
  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.easeIn}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');
    if (date == _datePickerState.widget.currentDate) return;

    _datePickerState._controller
        .animateTo(date.day * oneDateWidth - oneDateWidth,
            // _calculateDateOffset(date),
            duration: duration,
            curve: curve);
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    var offset =
        (date.difference(_datePickerState.widget.endDate).inDays).abs();
    print(offset);
    return (offset * oneDateWidth) - (oneDateWidth * 1);
  }
}
