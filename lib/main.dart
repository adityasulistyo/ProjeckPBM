import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _locationMessage = "";
  String _imsakTime = "";
  String _maghribTime = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  //mendapatkan koordinat kota
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // mendapatkan nama kota berdasarkan koordinat
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // mengambil nama kota dari Placemark
    String? cityName = placemarks[0].locality;

    setState(() {
      _locationMessage = "$cityName";
      _getImsakMaghribTime(position.latitude, position.longitude);
    });
  }

  //fungsi untuk mengambil waktu imsak dan maghrib sesuai dengan lokasi pengguna
  void _getImsakMaghribTime(double latitude, double longitude) async {
    var url =
        "http://api.aladhan.com/v1/timingsByCity?city=Jakarta&country=Indonesia&latitude=$latitude&longitude=$longitude&method=8";
    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);

    var data = decodedJson["data"];
    var timings = data["timings"];

    setState(() {
      _imsakTime = timings["Imsak"];
      _maghribTime = timings["Maghrib"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Jadwal Buka Puasa"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Lokasi saat ini:",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                _locationMessage,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Waktu Imsak: $_imsakTime",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Waktu Maghrib: $_maghribTime",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
