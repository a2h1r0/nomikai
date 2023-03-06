import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Auth? _userFromFirebaseUser(User? user) {
    return user != null ? Auth(uid: user.uid, email: user.email!) : null;
  }

  Stream<Auth?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<FirebaseAuthResultStatus> loginWithEmailAndPassword(
      String email, String password) async {
    FirebaseAuthResultStatus result;
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final Auth? auth = _userFromFirebaseUser(userCredential.user);

      if (auth != null) {
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
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final Auth? auth = _userFromFirebaseUser(userCredential.user);

      if (auth != null) {
        final user = <String, dynamic>{
          'username': auth.uid,
          'email': auth.email,
          'createdAt': Timestamp.fromDate(DateTime.now()),
        };
        _firestore.collection('users').doc(auth.uid).set(user);

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

StreamProvider<Auth?> authStreamProvider =
    StreamProvider((ref) => AuthService().user);
