import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindsolver_flutter/models/user.dart';

class MyPageViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  UserDoc _userData = UserDoc(name: '', job: '', profileUrl: '', age: 0, gender: 0);

  UserDoc get userData => _userData;

  set userData(UserDoc value) {
    _userData = value;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot snapshot = await _firestore.collection('users').doc(userId).get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          userData = UserDoc(
            uid: snapshot.id,
            name: data['name'] ?? '',
            job: data['job'] ?? '',
            profileUrl: data['profileUrl'] ?? '',
            age: data['age'] ?? 0,
            gender: data['gender'] ?? 0,
          );
          print(userData);
        }
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }
}
