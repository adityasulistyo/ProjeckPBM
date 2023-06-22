import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'jadwal_page.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Jadwal>> getAllJadwal() async {
    List<Jadwal> jadwalList = [];

    QuerySnapshot snapshot = await _firestore.collection('jadwal').get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      File gambar = await _getFileFromStorage(doc.id);
      Jadwal jadwal = Jadwal(
        gambar: gambar,
        deskripsi: doc.get('deskripsi'),
        tanggal: (doc.get('tanggal') as Timestamp).toDate(),
      );
      jadwalList.add(jadwal);
    }

    return jadwalList;
  }

  Future<File> _getFileFromStorage(String jadwalId) async {
    String filePath = 'gambar/$jadwalId.jpg';

    File file = File(filePath);

    if (await file.exists()) {
      return file;
    } else {
      try {
        await _storage.ref(filePath).writeToFile(file);
        return file;
      } catch (e) {
        print('Error retrieving file from storage: $e');
        return File('path/to/placeholder_image.jpg');
      }
    }
  }
}
