import 'package:flutter/material.dart';
import 'package:puasa/home_page.dart';
// import 'package:puasa/jadwal_page.dart';
import 'package:puasa/tips.dart';
import 'package:puasa/jadwal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puasa/jadwal.dart';

class NavigationSection extends StatefulWidget {
  @override
  _NavigationSectionState createState() => _NavigationSectionState();
}

class _NavigationSectionState extends State<NavigationSection> {
  int _currentPageIndex = 0;

  @override
  void _navigateToPage(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });

    // Navigasi ke halaman yang sesuai
    switch (pageIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsSection()),
        ); // Navigasi ke halaman Tips
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ),
        ); // Navigasi ke halaman Jadwal
        break;
      case 3:
        // Navigasi ke halaman Akun
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _navigateToPage(0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () => _navigateToPage(0),
                  icon: Icon(
                    Icons.home,
                    color: _currentPageIndex == 0 ? Colors.green : Colors.black,
                  ),
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentPageIndex == 0 ? Colors.green : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(1),
            child: Column(
              children: [
                IconButton(
                  onPressed: () => _navigateToPage(1),
                  icon: Icon(
                    Icons.lightbulb,
                    color: _currentPageIndex == 1 ? Colors.green : Colors.black,
                  ),
                ),
                Text(
                  'Tips',
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentPageIndex == 1 ? Colors.green : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(2),
            child: Column(
              children: [
                IconButton(
                  onPressed: () => _navigateToPage(2),
                  icon: Icon(
                    Icons.calendar_today,
                    color: _currentPageIndex == 2 ? Colors.green : Colors.black,
                  ),
                ),
                Text(
                  'Jadwal',
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentPageIndex == 2 ? Colors.green : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _navigateToPage(3),
            child: Column(
              children: [
                IconButton(
                  onPressed: () => _navigateToPage(3),
                  icon: Icon(
                    Icons.person,
                    color: _currentPageIndex == 3 ? Colors.green : Colors.black,
                  ),
                ),
                Text(
                  'Akun',
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentPageIndex == 3 ? Colors.green : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
