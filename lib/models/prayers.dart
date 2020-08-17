import 'package:flutter/material.dart';

class PrayersType {
  final int id;
  final String prayerAr;
  final String prayerEn;

  PrayersType({this.id, this.prayerAr, this.prayerEn});
}

List<PrayersType> prayersList = [
  PrayersType(
      id: 0,
      prayerAr:
          "أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر.",
      prayerEn: "Thanks God! For all your guide and mercy"),
  PrayersType(
      id: 1,
      prayerAr:
          "اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ .",
      prayerEn: "Guide us Lord to the right way"),
  PrayersType(
      id: 2,
      prayerAr:
          "اللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمهااللهم اغفر لأمي و ارحمها",
      prayerEn: "We ask for your forgivness Lord"),
  PrayersType(
      id: 3,
      prayerAr: "اللهم اشف مرضانا ومرضى المسلمين",
      prayerEn: "We ask you Lord to heal the sick"),
  PrayersType(
      id: 4,
      prayerAr:
          "رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً",
      prayerEn: "We ask you Lord to heal the sick"),
  PrayersType(
      id: 5,
      prayerAr:
          "اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك. ",
      prayerEn: "We ask you Lord to heal the sick"),
  PrayersType(
      id: 6,
      prayerAr:
          "أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ. ",
      prayerEn: "We ask you Lord to heal the sick"),
];

class HomePageCardTodaysPrayer extends StatelessWidget {
  const HomePageCardTodaysPrayer({
    Key key,
  }) : super(key: key);

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
                  Icons.book,
                ),
                Spacer(),
                Text(
                  "ذِكر",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              "اختر دعاء عشوائي حسب توقيت اليوم",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
