import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './auth.page.dart';
import './home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puasa/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BukaPuasaApp());
}

class BukaPuasaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green, // Warna hijau untuk primary color
          hintColor: Colors.greenAccent, // Warna hijau untuk accent color
          // Atur warna lainnya sesuai kebutuhan
        ),
        home: LoginPage(),
        routes: {
          HomePage.route: (ctx) => HomePage(),
        },
      ),
    );
  }
}
