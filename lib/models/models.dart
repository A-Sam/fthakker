import 'package:flutter/material.dart';

class TabView {
  final int id;
  final String tabNameEn;
  final String tabNameAr;
  final Icon tabIcon;

  TabView({this.id, this.tabNameEn, this.tabNameAr, this.tabIcon});
}

List<TabView> tabViewsList = [
  TabView(
      id: 0,
      tabNameEn: "Home",
      tabNameAr: "الرئيسية",
      tabIcon: Icon(Icons.home)),
  TabView(
      id: 1,
      tabNameEn: "Prayers",
      tabNameAr: "ذِكر",
      tabIcon: Icon(Icons.book)),
  TabView(
      id: 2,
      tabNameEn: "Calendar",
      tabNameAr: "التقويم",
      tabIcon: Icon(Icons.event_note)),
  TabView(
      id: 3,
      tabNameEn: "More",
      tabNameAr: "المزيد",
      tabIcon: Icon(Icons.more_horiz))
];
