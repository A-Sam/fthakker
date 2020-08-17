import 'package:flutter/material.dart';
import 'package:fthakker/models/models.dart';
import 'package:fthakker/models/prayers.dart';
import 'package:fthakker/size_config.dart';

class PrayerCard extends StatelessWidget {
  final PrayersType prayerElement;
  final Function press;

  const PrayerCard({Key key, this.prayerElement, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(prayerElement.prayerAr,
                                textAlign: TextAlign.right,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0)),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  autofocus: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                                FlatButton(
                                  autofocus: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(25), //18
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Center(
              child: Text(
                prayerElement.prayerAr,
                style: TextStyle(
                    fontSize: 20, //22
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                prayerElement.prayerEn,
                style: TextStyle(
                    fontSize: 20, //22
                    color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
