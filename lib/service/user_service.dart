import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomikai/model/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> getUserList() async {
    // todo: users空の場合の挙動を確認
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    List<User> users = snapshot.docs
        .map((doc) => User(username: doc.get('username')))
        .toList();

    return users;
  }
}
