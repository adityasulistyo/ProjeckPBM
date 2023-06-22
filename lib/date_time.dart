import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:analog_clock/analog_clock.dart';

class DateTimeCountdownSection extends StatefulWidget {
  @override
  _DateTimeCountdownSectionState createState() =>
      _DateTimeCountdownSectionState();
}

class _DateTimeCountdownSectionState extends State<DateTimeCountdownSection> {
  String currentDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String currentTime = DateFormat('HH:mm').format(DateTime.now());
  String imsakTime = '';
  String fajrTime = '';
  String dhuhrTime = '';
  String asrTime = '';
  String maghribTime = '';
  String ishaTime = '';
  String nearestPrayer = '';
  String nearestPrayerName = '';
  int countdownDuration = 0;

  @override
  void initState() {
    super.initState();
    _fetchPrayerTimes();
  }

  Future<void> _fetchPrayerTimes() async {
    // Sending an HTTP request to the Aladhan API
    String apiUrl =
        'http://api.aladhan.com/v1/timingsByCity?city=Jember&country=Indonesia';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parsing JSON data
      var data = json.decode(response.body);
      var timings = data['data']['timings'];

      setState(() {
        // Updating prayer times on the UI
        imsakTime = timings['Imsak'];
        fajrTime = timings['Fajr'];
        dhuhrTime = timings['Dhuhr'];
        asrTime = timings['Asr'];
        maghribTime = timings['Maghrib'];
        ishaTime = timings['Isha'];
      });

      _getNearestPrayer();
      _startCountdown();
    } else {
      // Handling error if the request fails
      print('Failed to fetch prayer times');
    }
  }

  void _getNearestPrayer() {
    List<String> prayerTimes = [
      imsakTime,
      fajrTime,
      dhuhrTime,
      asrTime,
      maghribTime,
      ishaTime
    ];
    List<String> prayerNames = [
      'Imsak',
      'Subuh',
      'Dhuhr',
      'Asr',
      'Maghrib',
      'Isha'
    ];
    DateTime now = DateTime.now();
    int minDiff = 24 * 60;
    String nearestTime = '';
    String nearestName = '';

    for (int i = 0; i < prayerTimes.length; i++) {
      String prayerTime = prayerTimes[i];
      List<String> timeParts = prayerTime.split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      DateTime prayerDateTime =
          DateTime(now.year, now.month, now.day, hour, minute);
      int diff = prayerDateTime.difference(now).inMinutes;

      if (diff > 0 && diff < minDiff) {
        minDiff = diff;
        nearestTime = prayerTime;
        nearestName = prayerNames[i];
      }
    }

    setState(() {
      nearestPrayer = nearestTime;
      nearestPrayerName = nearestName;
      countdownDuration = minDiff * 60;
    });
  }

  void _startCountdown() {
    setState(() {
      countdownDuration -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentDate,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Cormor-Light',
              ),
            ),
            SizedBox(height: 10),
            Text(
              nearestPrayerName.isNotEmpty ? nearestPrayerName : '',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Cormor-SemiBold',
              ),
            ),
            SizedBox(height: 10),
            CountdownTimer(
              endTime: DateTime.now().millisecondsSinceEpoch +
                  countdownDuration * 1000,
              textStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'Cormor-Regular',
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Imsak',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-SemiBold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            imsakTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Subuh',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-Semibold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            fajrTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Dhuhr',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-SemiBold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            dhuhrTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Asr',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-SemiBold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            asrTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Maghrib',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-SemiBold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            maghribTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(height: 2),
                          Text(
                            'Isha',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Cormor-SemiBold',
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            ishaTime,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Cormor-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
