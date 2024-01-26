import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindsolver_flutter/models/user.dart';

class AuthViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<UserDoc?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await _usersCollection.doc(user.uid).get().then((doc) {
        if (doc.exists) {
          return UserDoc(
            uid: doc['uid'],
            name: doc['name'],
            profileUrl: doc['profileUrl'],
          );
        } else {
          return null;
        }
      });
    } else {
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      }

      final authentication = await googleSignInAccount.authentication;

      final authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(authCredential);
      final user = authResult.user;

      if (user == null) {
        return;
      }

      final bool userExists = await _usersCollection.doc(user.uid).get().then((doc) {
        return doc.exists;
      });

      if (userExists) {
        return;
      }

      await addUser(UserDoc(
        uid: user.uid,
        name: user.displayName ?? 'Anonymous',
        profileUrl: user.photoURL ?? '',
      ));
    } catch (error) {
      print(error);
    }
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
