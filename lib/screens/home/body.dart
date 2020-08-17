import 'package:flutter/material.dart';
import 'package:fthakker/models/models.dart';
import 'package:fthakker/models/prayers.dart';
import 'package:fthakker/screens/prayer_card.dart';
import 'package:fthakker/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10), //20
              child: GridView.builder(
                itemCount: prayersList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing:
                      SizeConfig.orientation == Orientation.landscape
                          ? SizeConfig.defaultSize
                          : 0,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) => PrayerCard(
                  prayerElement: prayersList[index],
                  press: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
