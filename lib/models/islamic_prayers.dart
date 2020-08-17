import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:thakker/date_picker_timeline/date_picker_widget.dart';
import 'package:thakker/size_config.dart';

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
      id: 1, prayerAr: "الظهر", prayerEn: "Dhuhr", prayerTime: "12.00"),
  IslamicPrayersType(
      id: 2, prayerAr: "العصر", prayerEn: "Asr", prayerTime: "20.00"),
  IslamicPrayersType(
      id: 3, prayerAr: "المغرب", prayerEn: "Maghrib", prayerTime: "18.00"),
  IslamicPrayersType(
      id: 4, prayerAr: "العشاء", prayerEn: "Isha", prayerTime: "20.00"),
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
                Text(
                  "الصلاة",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DatePicker(
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
                  daysCount: totalNoOfDaysInCurrentMonth,
                ),
              ],
            )),
            // ConstrainedBox(
            //   constraints: BoxConstraints(
            //     maxWidth: SizeConfig.screenWidth,
            //     maxHeight: 60,
            //   ),
            //   child: ListView(
            //     reverse: true,
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     physics: BouncingScrollPhysics(),
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.white),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               children: <Widget>[
            //                 Text(islamicPrayersList[0].prayerAr),
            //                 SizedBox(
            //                   height: 5.0,
            //                 ),
            //                 Text(
            //                   islamicPrayersList[0].prayerTime,
            //                   style: TextStyle(fontSize: 10.0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(5.0),
            //               color: Colors.amber),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               children: <Widget>[
            //                 Text(
            //                   islamicPrayersList[1].prayerAr,
            //                   textDirection: TextDirection.rtl,
            //                   textAlign: TextAlign.center,
            //                 ),
            //                 SizedBox(
            //                   height: 5.0,
            //                 ),
            //                 Text(
            //                   islamicPrayersList[1].prayerTime,
            //                   style: TextStyle(fontSize: 10.0),
            //                   textDirection: TextDirection.rtl,
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.white),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               children: <Widget>[
            //                 Text(islamicPrayersList[2].prayerAr),
            //                 SizedBox(
            //                   height: 5.0,
            //                 ),
            //                 Text(
            //                   islamicPrayersList[2].prayerTime,
            //                   style: TextStyle(fontSize: 10.0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.white),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               children: <Widget>[
            //                 Text(islamicPrayersList[3].prayerAr),
            //                 SizedBox(
            //                   height: 5.0,
            //                 ),
            //                 Text(
            //                   islamicPrayersList[3].prayerTime,
            //                   style: TextStyle(fontSize: 10.0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10.0),
            //               color: Colors.white),
            //           child: Padding(
            //             padding: const EdgeInsets.all(5.0),
            //             child: Column(
            //               children: <Widget>[
            //                 Text(islamicPrayersList[4].prayerAr),
            //                 SizedBox(
            //                   height: 5.0,
            //                 ),
            //                 Text(
            //                   islamicPrayersList[4].prayerTime,
            //                   style: TextStyle(fontSize: 10.0),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
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
