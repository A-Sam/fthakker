import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageCardFastReminder extends StatefulWidget {
  const HomePageCardFastReminder({
    Key key,
  }) : super(key: key);

  @override
  _HomePageCardFastReminderState createState() =>
      _HomePageCardFastReminderState();
}

class _HomePageCardFastReminderState extends State<HomePageCardFastReminder>
    with AutomaticKeepAliveClientMixin<HomePageCardFastReminder> {
  int fastingFaridaDaysCounter = 0, fastingNafelaDaysCounter = 0;
  int ramadanDaysCounter;
  HijriCalendar hijriDate = HijriCalendar();

  _updateFastingFaridaBalance(int counter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fastingFaridaDaysCounter =
        (prefs.getInt('fastingFaridaDaysCounter') ?? 0) + counter;
    await prefs.setInt('fastingFaridaDaysCounter', fastingFaridaDaysCounter);
  }

  _updateFastingNafelaBalance(int counter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fastingNafelaDaysCounter =
        (prefs.getInt('fastingNafelaDaysCounter') ?? 0) + counter;
    await prefs.setInt('fastingNafelaDaysCounter', fastingNafelaDaysCounter);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    HijriCalendar.setLocal("ar");
    hijriDate = HijriCalendar.now();

    ramadanDaysCounter = _updateRamadanCounter();

    _refreshOnStartup().then((value) {
      setState(() {
        _updateFastingFaridaBalance(0);
        _updateFastingNafelaBalance(0);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refreshOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.assignment,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "الصوم",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "رصيد الفريضة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              setState(() {
                                _updateFastingFaridaBalance(1);
                              });
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: fastingFaridaDaysCounter >= 0
                                    ? Colors.green
                                    : Colors.red),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "$fastingFaridaDaysCounter",
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              setState(() {
                                _updateFastingFaridaBalance(-1);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "رصيد النافلة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              setState(() {
                                _updateFastingNafelaBalance(1);
                              });
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: fastingNafelaDaysCounter >= 0
                                    ? Colors.green
                                    : Colors.red),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "$fastingNafelaDaysCounter",
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              setState(() {
                                _updateFastingNafelaBalance(-1);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
            ),
            Text(
              "متبقي حتى رمضان القادم:",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "" + ramadanDaysCounter.toString() + " يوم",
                        style: TextStyle(fontSize: 25.0),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _updateRamadanCounter() {
    int hijriYearHasRamadan;

    DateTime todayGeorgian = hijriDate.hijriToGregorian(
        hijriDate.hYear, hijriDate.hMonth, hijriDate.hDay);

    hijriYearHasRamadan =
        hijriDate.hMonth < 9 ? hijriDate.hYear : hijriDate.hYear + 1;

    DateTime ramdanStartDate =
        hijriDate.hijriToGregorian(hijriYearHasRamadan, 9, 1);

    var durationToRamadanGeorgian = ramdanStartDate.difference(todayGeorgian);

    return durationToRamadanGeorgian.inDays;
  }
}
