import 'package:flutter/material.dart';
import 'package:puasa/profile.dart';
import 'package:puasa/date_time.dart';
import 'package:puasa/navigation.dart';
import 'package:puasa/news_section.dart';

class HomePage extends StatelessWidget {
  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
      // bottomNavigationBar: NavigationSection(),
    );
  }
}

class ThemedHomePage extends StatelessWidget {
  static const route = "/home";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      primaryColor: Colors.green, // Warna hijau untuk primary color
      hintColor: Colors.greenAccent, // Warna hijau untuk accent color
      // Atur warna lainnya sesuai kebutuhan
    );

    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Aplikasi Buka Puasa',
            style: TextStyle(fontFamily: 'Exo2'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
              top: 0), // Sesuaikan padding atas sesuai kebutuhan
          child: Column(
            children: [
              ProfileSection(),
              DateTimeCountdownSection(),
              NewsSection(),
              NavigationSection(),
            ],
          ),
        ),
      ),
    );
  }
}
