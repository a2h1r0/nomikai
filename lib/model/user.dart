import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final Timestamp createdAt;
  User({required this.uid, required this.createdAt});
}
