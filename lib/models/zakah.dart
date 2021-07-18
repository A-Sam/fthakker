import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageCardZakahReminder extends StatefulWidget {
  const HomePageCardZakahReminder({
    Key key,
  }) : super(key: key);

  @override
  _HomePageCardZakahReminderState createState() =>
      _HomePageCardZakahReminderState();
}

class _HomePageCardZakahReminderState extends State<HomePageCardZakahReminder>
    with AutomaticKeepAliveClientMixin<HomePageCardZakahReminder> {
  DateTime zakahStartDate = DateTime.now(), zakahEndDate = DateTime.now();
  int zakahStartDateYear, zakahStartDateMonth, zakahStartDateDay;
  double zakahValue, savingsValue;
  TextEditingController _controllerZakahStartDateY;
  TextEditingController _controllerZakahStartDateM;
  TextEditingController _controllerZakahStartDateD;
  TextEditingController _controllerZakahStartSavings;

  @override
  void initState() {
    super.initState();

    getZakahDetails();

    _refreshOnStartup().then((value) {
      setState(() {
        getZakahDetails();
      });
    });
  }

  @override
  void dispose() {
    setZakahDetails();

    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  getZakahDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    savingsValue = prefs.getDouble('savingsValue');
    _controllerZakahStartSavings =
        TextEditingController(text: savingsValue.toString());

    zakahStartDateYear = prefs.getInt('zakahStartDateYear');
    _controllerZakahStartDateY =
        TextEditingController(text: zakahStartDateYear.toString());

    zakahStartDateMonth = prefs.getInt('zakahStartDateMonth');
    _controllerZakahStartDateM =
        TextEditingController(text: zakahStartDateMonth.toString());

    zakahStartDateDay = prefs.getInt('zakahStartDateDay');
    _controllerZakahStartDateD = TextEditingController()
      ..text = zakahStartDateDay.toString();

    zakahStartDate =
        DateTime(zakahStartDateYear, zakahStartDateMonth, zakahStartDateDay);

    if (zakahStartDate != null)
      zakahEndDate = zakahStartDate.add(Duration(days: 365));

    zakahValue = savingsValue != null ? savingsValue / 40 : 0;
  }

  setZakahDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('savingsValue', savingsValue);
    await prefs.setInt('zakahStartDateYear', zakahStartDateYear);
    await prefs.setInt('zakahStartDateMonth', zakahStartDateMonth);
    await prefs.setInt('zakahStartDateDay', zakahStartDateDay);

    zakahValue = savingsValue != null ? savingsValue / 40 : 0;
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
                  Icons.account_balance,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.amber),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "الزكاة",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Column(
                          children: [
                            Text(
                              "بداية العام",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            Row(
                              textDirection: TextDirection.rtl,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 50,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _controllerZakahStartDateD,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "ي",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                    enableSuggestions: false,
                                    expands: false,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    minLines: 1,
                                    onChanged: (val) {
                                      zakahStartDateDay = int.parse(val);
                                      setState(() {
                                        setZakahDetails();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 50,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _controllerZakahStartDateM,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      labelText: "ش",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                    enableSuggestions: false,
                                    expands: false,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    minLines: 1,
                                    onChanged: (val) {
                                      zakahStartDateMonth = int.parse(val);
                                      setState(() {
                                        setZakahDetails();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 70,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _controllerZakahStartDateY,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelText: "سنة",
                                    ),
                                    enableSuggestions: false,
                                    expands: false,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    minLines: 1,
                                    onChanged: (val) {
                                      zakahStartDateYear = int.parse(val);
                                      setState(() {
                                        setZakahDetails();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Text(
                            "نهاية العام",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    zakahEndDate.year.toString() +
                                        "." +
                                        zakahEndDate.month.toString() +
                                        "." +
                                        zakahEndDate.day.toString(),
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180.0,
                        child: Column(children: [
                          Text(
                            "إجمالي المدخر بداية العام",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _controllerZakahStartSavings,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                filled: true,
                                labelText: "القيمة",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),
                              enableSuggestions: false,
                              expands: false,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              minLines: 1,
                              onChanged: (val) {
                                savingsValue = double.parse(val);
                                setState(() {
                                  setZakahDetails();
                                });
                              },
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          Text(
                            "قيمة الزكاة",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    zakahValue != null
                                        ? "\$ " + zakahValue.round().toString()
                                        : "\$ 0",
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
