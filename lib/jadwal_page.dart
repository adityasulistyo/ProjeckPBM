import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class JadwalPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String tanggal;

  JadwalPage({
    required this.imageUrl,
    required this.description,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              tanggal,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: JadwalList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddScheduleDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newImageUrl = '';
        String newDescription = '';
        String newTanggal = '';

        Future<void> _getImage(ImageSource source) async {
          final picker = ImagePicker();
          final pickedImage = await picker.pickImage(source: source);

          if (pickedImage != null) {
            newImageUrl = pickedImage.path;
          }
        }

        return AlertDialog(
          title: Text('Add Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _getImage(ImageSource.camera);
                    },
                    child: Text('Camera'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getImage(ImageSource.gallery);
                    },
                    child: Text('Gallery'),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  newDescription = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tanggal'),
                onChanged: (value) {
                  newTanggal = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _saveSchedule(
                  newImageUrl,
                  newDescription,
                  newTanggal,
                );

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _saveSchedule(
      String imageUrl, String description, String tanggal) async {
    CollectionReference schedulesCollection =
        FirebaseFirestore.instance.collection('schedules');

    await schedulesCollection.add({
      'imageUrl': imageUrl,
      'description': description,
      'tanggal': tanggal,
    });
  }
}

class JadwalList extends StatelessWidget {
  final CollectionReference schedulesCollection =
      FirebaseFirestore.instance.collection('schedules');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: schedulesCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }

        if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return Text('No schedules found.');
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> scheduleData =
                document.data() as Map<String, dynamic>;

            return ListTile(
              leading: Image.network(
                scheduleData['imageUrl'] ?? '',
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(scheduleData['description'] ?? ''),
              subtitle: Text(scheduleData['tanggal'] ?? ''),
            );
          }).toList(),
        );
      },
    );
  }
}
