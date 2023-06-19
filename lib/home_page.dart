import 'package:flutter/material.dart';
import './profile.dart';
import './date_time.dart';
import './navigation.dart';
import './news_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aplikasi Buka Puasa',
          style: TextStyle(fontFamily: 'Exo2'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 0), // Adjust the top padding as needed
        child: Column(
          children: [
            ProfileSection(),
            DateTimeCountdownSection(),
            NewsSection(),
            NavigationSection(),
          ],
        ),
      ),
    );
  }
}
