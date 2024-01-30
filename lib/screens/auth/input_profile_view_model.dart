import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindsolver_flutter/models/user.dart';

class InputProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String _profileUrl = '';
  String get profileUrl => _profileUrl;
  set profileUrl(String url) {
    _profileUrl = url;
    notifyListeners();
  }

  bool _isUploading = false;
  bool get isUploading => _isUploading;
  set isUploading(bool b) {
    _isUploading = b;
    notifyListeners();
  }

  Future<void> pickImage() async {
    isUploading = true;
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadImage(pickedFile.path);
    }
    isUploading = false;
  }

  Future<void> uploadImage(String filePath) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return;
    }

    final ref = _storage
        .ref() //
        .child('users')
        .child(uid)
        .child('profile.png');

    final uploadTask = ref.putFile(File(filePath));

    final snapshot = await uploadTask.whenComplete(() => null);

    profileUrl = await snapshot.ref.getDownloadURL();
  }

  Future<void> addUser(UserDoc user) async {
    try {
      final uid = _auth.currentUser?.uid;
      final ref = _firestore.collection('users').doc(uid);

      await ref.set({
        'uid': uid,
        'name': user.name,
        'age': user.age,
        'job': user.job,
        'profileUrl': user.profileUrl,
        'gener': user.gener,
      });
    } catch (e) {
      debugPrint('Error adding user: $e');
    }
  }
}
