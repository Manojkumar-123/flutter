import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> addDocument(
      {required uid, required did, required fileName, required doc}) async {
    String res = "Something went wrong";
    try {
      await _firebaseStorage.ref('documents/$uid/$fileName').putFile(File(doc));
      res = "success";
    } catch (err) {
      res.toString();
    }
    return res;
  }
}
