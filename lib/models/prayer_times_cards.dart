import 'package:flutter/material.dart';
import 'package:fthakker/date_picker_timeline/date_picker_widget.dart';
import 'package:fthakker/models/date_singelton.dart';
import 'package:fthakker/models/prayer_times.dart';

class IslamicPrayersType {
  final int id;
  final String prayerAr;
  final String prayerEn;
  final String prayerTime;

  IslamicPrayersType({this.id, this.prayerAr, this.prayerEn, this.prayerTime});
}

List<IslamicPrayersType> islamicPrayersList = [
  IslamicPrayersType(
      id: 0, prayerAr: "الفجر", prayerEn: "Fajr", prayerTime: "02.00"),
  IslamicPrayersType(
      id: 1, prayerAr: "الشروق", prayerEn: "Sunrise", prayerTime: "02.00"),
  IslamicPrayersType(
      id: 2, prayerAr: "الظهر", prayerEn: "Dhuhr", prayerTime: "12.00"),
  IslamicPrayersType(
      id: 3, prayerAr: "العصر", prayerEn: "Asr", prayerTime: "20.00"),
  IslamicPrayersType(
      id: 4, prayerAr: "المغرب", prayerEn: "Maghrib", prayerTime: "18.00"),
  IslamicPrayersType(
      id: 5, prayerAr: "العشاء", prayerEn: "Isha", prayerTime: "20.00"),
];

class HomePageCardPrayerTimes extends StatefulWidget {
  const HomePageCardPrayerTimes({
    Key key,
  }) : super(key: key);

  @override
  _HomePageCardPrayerTimesState createState() =>
      _HomePageCardPrayerTimesState();
}

class _HomePageCardPrayerTimesState extends State<HomePageCardPrayerTimes> {
  DatePickerController _controller = DatePickerController();
  PrayTimes prayTimes =
      PrayTimes(latitude: 48.092724, longtidue: 11.502992, timeZone: 2);

  @override
  void initState() {
    super.initState();

    _refreshOnStartup().then((value) {
      _controller.animateToSelection();
    });
  }

  Future _refreshOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var totalNoOfDaysInCurrentMonth =
        DateTime(DateTime.now().year, DateTime.now().month, 0).day;
    var startDate =
        DateTime.now().subtract(Duration(days: DateTime.now().day - 1));

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.access_time,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "الصلاة",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                child: DatePicker(
              startDate,
              endDate: startDate
                  .add(Duration(days: totalNoOfDaysInCurrentMonth - 1)),
              locale: "ar_EG",
              initialSelectedDate: DateTime.now(),
              currentDate: DateTime.now(),
              selectionColor: Colors.amber,
              selectedTextColor: Colors.white,
              latestTapDetails: TapDownDetails(),
              controller: _controller,
              // hijriDate: HijriCalendar.now(),
              onDateChange: (selecteddate) {
                // print(selecteddate);
                // TODO::SAM Fix the sliding alg
                _controller.animateToSelection();
                // _controller.animateToDate(selecteddate,
                //     curve: Curves.decelerate);
              },
              daysCount: totalNoOfDaysInCurrentMonth, height: 200,
              width: 80,
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }
}
