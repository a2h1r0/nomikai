import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomikai/model/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> getUserList() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    List<User> users = snapshot.docs
        .map((doc) => User(uid: doc.id, username: doc.get('username')))
        .toList();

    return users;
  }
}
