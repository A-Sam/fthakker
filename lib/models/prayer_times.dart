import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
--------------------- Copyright Block ----------------------

praytimes.py: Prayer Times Calculator (ver 2.3)
Copyright (C) 2007-2011 PrayTimes.org

Python Code: Saleem Shafi, Hamid Zarrabi-Zadeh
Original js Code: Hamid Zarrabi-Zadeh

License: GNU LGPL v3.0

TERMS OF USE:
	Permission is granted to use this code, with or
	without modification, in any website or application
	provided that credit is given to the original work
	with a link back to PrayTimes.org.

This program is distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY.

PLEASE DO NOT REMOVE THIS COPYRIGHT BLOCK.


--------------------- Help and Manual ----------------------
User's Manual:
http://praytimes.org/manual

Calculation Formulas:
http://praytimes.org/calculation

*/

class PrayTimes {
  // Members
  static final PrayTimes _instance = PrayTimes._();
  PrayTimes._();

  static Map<String, List> prayTimesToday;
  static Map<int, Map<String, List>> prayTimesMonth = {};

  //------------------------ Constants --------------------------
  // Time Names
  static Map<String, String> timeNames = {
    'imsak': 'Imsak',
    'fajr': 'Fajr',
    'sunrise': 'Sunrise',
    'dhuhr': 'Dhuhr',
    'asr': 'Asr',
    'sunset': 'Sunset',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
    'midnight': 'Midnight'
  };

  // Calculation Methods
  static var methods = {
    'MWL': {
      'name': 'Muslim World League',
      'params': {'fajr': '18', 'isha': '17'}
    },
    'ISNA': {
      'name': 'Islamic Society of North America (ISNA)',
      'params': {'fajr': '15', 'isha': '15'}
    },
    'Egypt': {
      'name': 'Egyptian General Authority of Survey',
      'params': {'fajr': '19.5', 'isha': '17.5'}
    },
    'Makkah': {
      'name': 'Umm Al-Qura University, Makkah',
      'params': {'fajr': '18.5', 'isha': '90 min'}
    }, // fajr was 19 degrees before 1430 hijri
    'Karachi': {
      'name': 'University of Islamic Sciences, Karachi',
      'params': {'fajr': '18', 'isha': '18'}
    },
    'Tehran': {
      'name': 'Institute of Geophysics, University of Tehran',
      'params': {
        'fajr': '17.7',
        'isha': '14',
        'maghrib': '4.5',
        'midnight': 'Jafari'
      }
    }, // isha is not explicitly specified in this method
    'Jafari': {
      'name': 'Shia Ithna-Ashari, Leva Institute, Qum',
      'params': {
        'fajr': '16',
        'isha': '14',
        'maghrib': '4',
        'midnight': 'Jafari'
      }
    }
  };

  // Default Parameters in Calculation Methods
  static Map<String, String> defaultParams = {
    'maghrib': '0 min',
    'midnight': 'Standard'
  };

  // ---------------------- Default Settings --------------------

  static String calcMethod = 'MWL';

  // do not change anything here; use adjust method instead
  static Map<String, String> settings = {
    "imsak": '10 min',
    "dhuhr": '0 min',
    "maghrib": '0 min',
    "asr": 'Standard',
    "highLats": 'NightMiddle',
  };

  static String timeFormat = '24h';
  static List<String> timeSuffixes = ['am', 'pm'];
  static String invalidTime = '-----';
  static var numIterations = 1;
  static var offset = {};
  static double latitude = 0;
  static double longtidue = 0;
  static double elevation = 0;
  static double timeZone;
  static int jDate;

  // ---------------------- Initialization -----------------------

  factory PrayTimes(
      {method = "MWL",
      @required latitude,
      @required longtidue,
      @required timeZone,
      dst = 0.0}) {
    //TODO FIX I

    // set methods defaults
    methods.forEach((method, config) {
      defaultParams.forEach((name, value) {
        if ((config['params'] as Map).containsKey(name) ||
            !((config['params'] as Map).containsKey(name))) {
          (config['params'] as Map).putIfAbsent(name, () => value);
        }
      });
    });

    // initialize settings
    calcMethod = methods.containsKey(method) ? method : 'MWL';

    Map params = methods[calcMethod]['params'];

    params.forEach((name, value) {
      settings[name] = value;
    });

    // init time offsets
    timeNames.forEach((key, value) {
      offset.putIfAbsent(key, () => 0.0);
    });

    prayTimesToday = getTimes([
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ], [
      latitude,
      longtidue
    ], timeZone, dst: dst);

    for (int i = 1; i <= 31; i++) {
      prayTimesMonth.putIfAbsent(
          i,
          () => getTimes([
                DateTime.now().year,
                DateTime.now().month,
                i,
              ], [
                latitude,
                longtidue
              ], timeZone, dst: dst));
    }

    return _instance;
  }

  // -------------------- Interface Functions --------------------

  void setMethod(method) {
    if (methods.containsKey(method)) {
      adjust(methods[method]['params']);
      calcMethod = method;
    }
  }

  dynamic adjust(params) {
    //TODO fix
    // settings.update(params);
  }

  void tune(timeOffsets) {
    //TODO fix

    // offsets.update(timeOffsets);
  }

  dynamic getMethod() {
    return calcMethod;
  }

  // Map<String, String> getSettings() {
  //   return settings;
  // }

  // Map<String, String> getOffsets() {
  //   return offset;
  // }

  // def getDefaults():
  // 	return methods;

  // return prayer times for a given date
  static dynamic getTimes(date, coords, timezone, {format, dst}) {
    latitude = coords[0];
    longtidue = coords[1];
    elevation = (coords as List).length > 2 ? coords[2] : 0;

    if (format != null) {
      timeFormat = format;
    }

    timeZone = timezone + (dst == 0.0 ? 0.0 : 1.0);
    jDate =
        (julian(date[0], date[1], date[2]) - longtidue / (15 * 24.0)).floor();
    return computeTimes();
  }

  // convert float time to the given format (see timeFormats)
  static List getFormattedTime(time, format) {
    if ((time[0] as double).isNaN) {
      return [0.0, invalidTime];
    }

    if (format == 'Float') {
      return time;
    }

    time[0] = fixhour(time[0] + (0.5 / 60)); // add 0.5 minutes to round
    var hours = (time[0] as double).floor();
    var minutes = (((time[0] - hours) * 60) as double).floor();
    var suffix = (format == '12h' ? timeSuffixes[hours < 12 ? 0 : 1] : '');
    hours = (format == '24h' ? hours : (hours + 11) % 12 + 1);

    //todo fix III
    time[1] = hours.toString().padLeft(2, '0') +
        ':' +
        minutes.toString().padLeft(2, '0') +
        suffix;
    return time;
  }

  // ---------------------- Calculation Functions -----------------------

  // compute mid-day time
  static double midDay(time) {
    var eqt = sunPosition(jDate + time)[1];
    return fixhour(12 - eqt);
  }

  // compute the time at which sun reaches a specific angle below horizon
  static double sunAngleTime(angle, time, {direction}) {
    try {
      var decl = sunPosition(jDate + time)[0];
      var noon = midDay(time);
      var t = 1 /
          15.0 *
          arccos((-sin(angle) - sin(decl) * sin(latitude)) /
              (cos(decl) * cos(latitude)));
      return noon + (direction == 'ccw' ? -t : t);
    } catch (e) {
      return double.nan;
    }
  }

  // compute asr time
  static double asrTime(factor, time) {
    var decl = sunPosition(jDate + time)[0];
    var angle = -arccot(factor + tan((latitude - decl).abs()));
    return sunAngleTime(angle, time);
  }

  // compute declination angle of sun and equation of time
  // Ref: http://aa.usno.navy.mil/faq/docs/SunApprox.php
  static List sunPosition(jd) {
    var D = jd - 2451545.0;
    var g = fixangle(357.529 + 0.98560028 * D);
    var q = fixangle(280.459 + 0.98564736 * D);
    var L = fixangle(q + 1.915 * sin(g) + 0.020 * sin(2 * g));

    var R = 1.00014 - 0.01671 * cos(g) - 0.00014 * cos(2 * g);
    var e = 23.439 - 0.00000036 * D;

    var RA = arctan2(cos(e) * sin(L), cos(L)) / 15.0;
    var eqt = q / 15.0 - fixhour(RA);
    var decl = arcsin(sin(e) * sin(L));

    return [decl, eqt];
  }

  // convert Gregorian date to Julian day
  // Ref: Astronomical Algorithms by Jean Meeus
  static double julian(year, month, day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }
    var A = ((year / 100) as double).floor();
    var B = 2 - A + (A / 4).floor();
    return (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        B -
        1524.5;
  }

  // ---------------------- Compute Prayer Times -----------------------

  // compute prayer times at given julian date
  static Map<String, List> computePrayerTimes(times) {
    var timesInDays = dayPortion(times);
    var params = settings;
    var imsak = sunAngleTime(eval(params['imsak']), timesInDays['imsak'][0],
        direction: 'ccw');
    var fajr = sunAngleTime(eval(params['fajr']), timesInDays['fajr'][0],
        direction: 'ccw');
    var sunrise = sunAngleTime(
        riseSetAngle(elv: elevation), timesInDays['sunrise'][0],
        direction: 'ccw');
    var dhuhr = midDay(timesInDays['dhuhr'][0]);
    var asr = asrTime(asrFactor(params['asr']), timesInDays['asr'][0]);
    var sunset =
        sunAngleTime(riseSetAngle(elv: elevation), timesInDays['sunset'][0]);
    var maghrib =
        sunAngleTime(eval(params['maghrib']), timesInDays['maghrib'][0]);
    var isha = sunAngleTime(eval(params['isha']), timesInDays['isha'][0]);
    return {
      'imsak': [imsak, '00:00'],
      'fajr': [fajr, '00:00'],
      'sunrise': [sunrise, '00:00'],
      'dhuhr': [dhuhr, '00:00'],
      'asr': [asr, '00:00'],
      'sunset': [sunset, '00:00'],
      'maghrib': [maghrib, '00:00'],
      'isha': [isha, '00:00'],
      'midnight': [isha, '00:00']
    };
  }

  // compute prayer times
  static dynamic computeTimes() {
    Map<String, List> times = {
      'imsak': [5.0, ''],
      'fajr': [5.0, ''],
      'sunrise': [6.0, ''],
      'dhuhr': [12.0, ''],
      'asr': [13.0, ''],
      'sunset': [18.0, ''],
      'maghrib': [18.0, ''],
      'isha': [18.0, ''],
      'midnight': [11.0, ''],
    };

    // main iterations
    // TODO FIX number of iterations
    // for i in range(1):
    times = computePrayerTimes(times);

    //todo fix
    times = adjustTimes(times);

    // add midnight time
    if (settings['midnight'] == 'Jafari') {
      times['midnight'][0] = times['sunset'][0] +
          timeDiff(times['sunset'][0], times['fajr'][0]) / 2;
    } else {
      times['midnight'][0] = times['sunset'][0] +
          timeDiff(times['sunset'][0], times['sunrise'][0]) / 2;
    }

    times = tuneTimes(times);

    return modifyFormats(times);
  }

  // adjust times in a prayer time array
  static dynamic adjustTimes(times) {
    var params = settings;
    var tzAdjust = timeZone - longtidue / 15.0;

    (times as Map).forEach((t, v) {
      times[t][0] += tzAdjust;
    });

    if (params['highLats'] != 'None') times = adjustHighLats(times);

    if (isMin(params['imsak'])) {
      times['imsak'][0] = times['fajr'][0] - eval(params['imsak']) / 60.0;
    }

    // need to ask about 'min' settings
    if (isMin(params['maghrib'])) {
      times['maghrib'][0] = times['sunset'][0] - eval(params['maghrib']) / 60.0;
    }

    if (isMin(params['isha'])) {
      times['isha'][0] = times['maghrib'][0] - eval(params['isha']) / 60.0;
    }

    times['dhuhr'][0] += eval(params['dhuhr']) / 60.0;

    return times;
  }

  // get asr shadow factor
  static dynamic asrFactor(asrParam) {
    var methods = {'Standard': 1, 'Hanafi': 2};
    return methods.containsKey(asrParam) ? methods[asrParam] : asrParam;
  }

  // return sun angle for sunset/sunrise
  static double riseSetAngle({elv}) {
    elv ??= 0;
    return 0.833 + 0.0347 * math.sqrt(elv); // an approximation
  }

  // apply offsets to the times
  static Map<String, List> tuneTimes(times) {
    (times as Map<String, List>).forEach((name, value) {
      times[name][0] += offset[name] / 60.0;
    });

    return times;
  }

  // convert times to given time format
  static Map modifyFormats(times) {
    (times as Map<String, List>).forEach((name, value) {
      times[name] = getFormattedTime(times[name], timeFormat);
      // print(name + '' + times[name].toString());
    });

    return times;
  }

  // adjust times for locations in higher latitudes
  static Map adjustHighLats(times) {
    var params = settings;
    var nightTime =
        timeDiff(times['sunset'][0], times['sunrise'][0]); // sunset to sunrise
    times['imsak'][0] = adjustHLTime(
        times['imsak'][0], times['sunrise'][0], (params['imsak']), nightTime,
        direction: 'ccw');
    times['fajr'][0] = adjustHLTime(
        times['fajr'][0], times['sunrise'][0], (params['fajr']), nightTime,
        direction: 'ccw');
    times['maghrib'][0] = adjustHLTime(times['maghrib'][0], times['sunset'][0],
        (params['maghrib']), nightTime);
    times['isha'][0] = adjustHLTime(
        times['isha'][0], times['sunset'][0], (params['isha']), nightTime);
    return times;
  }

  // adjust a time for higher latitudes
  static double adjustHLTime(time, base, angle, night, {direction}) {
    var portion = nightPortion(angle, night);
    var diff = direction == 'ccw' ? timeDiff(time, base) : timeDiff(base, time);
    if ((time as double).isNaN || diff > portion)
      time = base + (direction == 'ccw' ? -portion : portion);
    return time;
  }

  // the night portion used for adjusting times in higher latitudes
  static double nightPortion(angle, night) {
    var method = settings['highLats'];
    var portion = 1 / 2.0; // midnight

    if (method == 'AngleBased') portion = 1 / 60.0 * angle;

    if (method == 'OneSeventh') portion = 1 / 7.0;

    return portion * night;
  }

  // convert hours to day portions
  static Map<String, List> dayPortion(times) {
    (times as Map<String, List>).forEach((key, val) {
      times[key][0] /= 24.0;
    });

    return times;
  }

  // ---------------------- Misc Functions -----------------------

  // compute the difference between two times
  static double timeDiff(time1, time2) {
    return fixhour(time2 - time1);
  }

  // convert given string into a number
  static double eval(String st) {
    if (st == null) return 0.0;
    String val = st.split(new RegExp('[^0-9.+-]'))[0];
    double iii = double.tryParse(val);

    return iii ??= 0.0;
  }

  // detect if input contains 'min'
  static bool isMin(String arg) {
    return (arg is String) && (arg.contains('min'));
  }

  // ----------------- Degree-Based Math Functions -------------------

  static double sin(d) {
    return math.sin(radians(d));
  }

  static double cos(d) {
    return math.cos(radians(d));
  }

  static double tan(d) {
    return math.tan(radians(d));
  }

  static double arcsin(x) {
    return degrees(math.asin(x));
  }

  static double arccos(x) {
    return degrees(math.acos(x));
  }

  static double arctan(x) {
    return degrees(math.atan(x));
  }

  static double arccot(x) {
    return degrees(math.atan(1.0 / x));
  }

  static double arctan2(y, x) {
    return degrees(math.atan2(y, x));
  }

  static double radians(degrees) {
    return degrees * math.pi / 180;
  }

  static double degrees(rad) {
    return rad * 180 / math.pi;
  }

  static double fixangle(angle) {
    return fix(angle, 360.0);
  }

  static double fixhour(hour) {
    return fix(hour, 24.0);
  }

  static double fix(a, mode) {
    if ((a as double).isNaN) return a;

    a = a - mode * ((a / mode) as double).floor();
    return a < 0 ? a + mode : a;
  }
}
