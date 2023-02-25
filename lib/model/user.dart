import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  User({required this.uid, required this.username});
}
