import 'package:flutter/material.dart';

import '../constants.dart';

class DatePicker extends StatefulWidget {
  DatePicker({Key key, this.minYear, this.maxYear}) : super(key: key);
  final int minYear;
  final int maxYear;

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 40,
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 70,
              child: ListView.builder(
                itemCount: Years.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                      child: Text(
                        Years[index].toString(),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    onTap: () {
                      print("");
                    },
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 70,
              child: ListView.builder(
                itemCount: Months.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Text(
                      Months[index + 1].toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 70,
              child: ListView.builder(
                itemCount: Days.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Text(
                      Days[index].toString(),
                      textAlign: TextAlign.left,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
