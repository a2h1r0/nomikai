import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/app_user.dart';

class UserService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<FirebaseAuthResultStatus> loginWithEmailAndPassword(
      String email, String password) async {
    FirebaseAuthResultStatus result;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      result = FirebaseAuthResult().handleException(e);
    }

    return result;
  }

  Future<FirebaseAuthResultStatus> registerWithEmailAndPassword(
      String email, String password) async {
    FirebaseAuthResultStatus result;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      result = FirebaseAuthResult().handleException(e);
    }

    return result;
  }

  Future<FirebaseAuthResultStatus> logout() async {
    FirebaseAuthResultStatus result;
    try {
      await _auth.signOut();
      result = FirebaseAuthResultStatus.successful;
    } catch (e) {
      result = FirebaseAuthResultStatus.undefined;
    }

    return result;
  }
}
