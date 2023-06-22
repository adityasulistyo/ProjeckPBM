import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  Future<String?> uploadImageToFirebase(
      File imageFile, String description, DateTime? selectedDate) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference =
          storage.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = reference.putFile(imageFile);

      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> saveImageDataToFirestore(
      String imagePath, String description, DateTime? date) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference imagesCollection = firestore.collection('images');

      await imagesCollection.add({
        'imagePath': imagePath,
        'description': description,
        'date': date,
      });

      print('Image data saved to Firestore.');
    } catch (e) {
      print('Error saving image data to Firestore: $e');
    }
  }
}
