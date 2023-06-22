import 'package:flutter/material.dart';
import 'package:puasa/auth.page.dart';
import './home_page.dart';

class AccountPage extends StatelessWidget {
  final String email;

  AccountPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/profile.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green), // Warna hijau untuk latar belakang tombol
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
