import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fthakker/date_picker_timeline/date_widget.dart';
import 'package:fthakker/models/date_singelton.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fthakker/models/fasting.dart';
import 'package:fthakker/models/prayer_times_cards.dart';
import 'package:fthakker/models/models.dart';
import 'package:fthakker/models/prayers.dart';
import 'package:fthakker/models/zakah.dart';
import 'package:fthakker/models/prayers_list.dart';
import 'package:fthakker/screens/prayer_card.dart';
import 'package:fthakker/size_config.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 1, vsync: this);
    _getThingsOnStartup().then((value) {});
    HijriCalendar.setLocal("ar");
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.screenWidth = MediaQuery.of(context).size.width;
    SizeConfig.screenHeight = MediaQuery.of(context).size.height;

    List<Widget> _widgetOptions = <Widget>[
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        HomePageCardPrayerTimes(),
                        SizedBox(height: 10.0),
                        HomePageCardZakahReminder(),
                        SizedBox(height: 10.0),
                        HomePageCardFastReminder(),
                        SizedBox(height: 10.0),
                        HomePageCardTodaysPrayer(),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
      PrayersList(),
      Text(
        'Index 2: أدعية',
        style: optionStyle,
      ),
      Text(
        'Index 3: المزيد',
        style: optionStyle,
      ),
    ];
    return Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          // Center(child: _widgetOptions.elementAt(3)),
          // Center(child: _widgetOptions.elementAt(2)),
          // Center(child: _widgetOptions.elementAt(1)),
          Center(child: _widgetOptions.elementAt(0)),
        ],
        controller: _tabController,
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.amber),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "فذكِّر",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          // Spacer(),
          IntrinsicHeight(
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    DateSingleton.todayHijriDate.getDayName(),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 15, color: Theme.of(context).accentColor),
                  ),
                ),
                VerticalDivider(
                  color: Theme.of(context).accentColor,
                ),
                Column(
                  children: [
                    Text(
                      DateSingleton.todayHijriDate.hDay.toString(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      DateTime.now().day.toString(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Theme.of(context).accentColor,
                ),
                Column(
                  children: [
                    Text(
                      DateSingleton.todayHijriDate.getLongMonthName(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      DateWidget.currentMonthEnglish,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Theme.of(context).accentColor,
                ),
                Column(
                  children: [
                    Text(
                      DateSingleton.todayHijriDate.hYear.toString(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                    Text(
                      DateTime.now().year.toString(),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Material buildBottomNavigationBar() {
    int _tabIndex = 3;

    return Material(
      color: Colors.white,
      elevation: 0.0,
      child: TabBar(
        controller: _tabController,
        indicatorColor: Colors.amber,
        labelColor: Colors.amber,
        unselectedLabelColor: Colors.black54,
        tabs: [
          Tab(
            icon: tabViewsList[(_tabIndex - 0).abs()].tabIcon,
            text: tabViewsList[(_tabIndex - 0).abs()].tabNameAr,
            iconMargin: EdgeInsets.all(1.0),
          ),
          Tab(
            icon: tabViewsList[(_tabIndex - 1).abs()].tabIcon,
            text: tabViewsList[(_tabIndex - 1).abs()].tabNameAr,
            iconMargin: EdgeInsets.all(1.0),
          ),
          Tab(
            icon: tabViewsList[(_tabIndex - 2).abs()].tabIcon,
            text: tabViewsList[(_tabIndex - 2).abs()].tabNameAr,
            iconMargin: EdgeInsets.all(1.0),
          ),
          Tab(
            icon: tabViewsList[(_tabIndex - 3).abs()].tabIcon,
            text: tabViewsList[(_tabIndex - 3).abs()].tabNameAr,
            iconMargin: EdgeInsets.all(1.0),
          ),
        ],
      ),
    );
  }
}
