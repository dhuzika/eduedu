import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // adding image to firebase storage
  Future<String> uploadImageToStorage(

    String childName, Uint8List file, bool isPostImage) async {
    // create the folder structure in firebase storage
    Reference storageObject =_storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadFile = storageObject.putData(file);

    TaskSnapshot snapResultProcess = await uploadFile;

    String downloadFileUrl = await snapResultProcess.ref.getDownloadURL();

    return downloadFileUrl;
  }
}
