import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puasa/database_service.dart';

import 'jadwal_page.dart';

class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  File? _image;
  final picker = ImagePicker();
  final DatabaseService _databaseService = DatabaseService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isUploading = false;

  String _description = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime; // New variable for selected time

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(
      String description, DateTime? date, TimeOfDay? time) async {
    if (_image != null) {
      setState(() {
        _isUploading = true;
      });

      String? imagePath = await _databaseService.uploadImageToFirebase(
        _image!,
        _description,
        _selectedDate,
      );
      if (imagePath != null) {
        print('Image uploaded to Firebase Storage: $imagePath');

        // Simpan data ke Firestore
        await _databaseService.saveImageDataToFirestore(
          imagePath,
          _description,
          _selectedDate,
        );

        showNotification('Image uploaded successfully');
      } else {
        print('Error uploading image to Firebase Storage.');
        showNotification('Error uploading image');
      }

      setState(() {
        _isUploading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  void showNotification(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Image Upload'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Pass the newly added Jadwal data back to the JadwalPage
                  Jadwal jadwal = Jadwal(
                    gambar: _image!,
                    deskripsi: _description,
                    tanggal: _selectedDate!,
                  );
                  Navigator.pop(context, jadwal);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Firebase Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.file(
                    _image!,
                    height: 200,
                  )
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Text('Choose Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => getImage(ImageSource.camera),
              child: Text('Take Photo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading
                  ? null
                  : () => uploadImageToFirebase(_description, _selectedDate,
                      _selectedTime), // Pass selected time
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green, // Set the background color to green
              ),
              child: _isUploading
                  ? CircularProgressIndicator()
                  : Text('Upload Image to Firebase'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            _selectedDate != null
                ? Text('Selected Date: ${_selectedDate!.toString()}')
                : Text('No date selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            SizedBox(height: 20),
            _selectedTime != null
                ? Text('Selected Time: ${_selectedTime!.format(context)}')
                : Text('No time selected.'),
          ],
        ),
      ),
    );
  }
}
