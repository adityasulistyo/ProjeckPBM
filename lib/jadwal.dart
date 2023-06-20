import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Image Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    if (_image == null) return;

    // Mendapatkan referensi Firebase Storage
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/${_image!.path}');

    // Mengunggah file ke Firebase Storage
    final UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    await uploadTask
        .whenComplete(() => print('Image uploaded to Firebase Storage.'));

    // Mendapatkan URL download gambar
    final imageUrl = await firebaseStorageRef.getDownloadURL();
    print('Download URL: $imageUrl');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded to Firebase Storage.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onPressed: getImage,
              child: Text('Choose Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text('Upload Image to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
