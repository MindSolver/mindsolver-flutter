import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindsolver_flutter/models/user.dart';

class AuthViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<bool> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return false;
      }

      final authentication = await googleSignInAccount.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(authCredential);
      final user = authResult.user;

      if (user == null) {
        return false;
      }
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
    return true;
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<bool> isUserExists() async {
    final uid = _auth.currentUser?.uid;
    final doc = await _usersCollection.doc(uid).get();
    return doc.exists;
  }

  Future<void> addUser(UserDoc user) async {
    await _usersCollection.doc(user.uid).set({
      'uid': user.uid,
      'name': user.name,
      'profileUrl': user.profileUrl,
    });
  }

  Future<void> updateUser(UserDoc user) async {
    await _usersCollection.doc(user.uid).update({
      'name': user.name,
      'profileUrl': user.profileUrl,
    });
  }
}
