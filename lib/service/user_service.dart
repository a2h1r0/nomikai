import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomikai/model/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<User>> getUserList() async {
    final QuerySnapshot snapshot = await _firestore.collection('users').get();
    final List<User> users = snapshot.docs
        .map((doc) => User(uid: doc.id, username: doc.get('username')))
        .toList();

    return users;
  }

  Future<User?> getUser(String uid) async {
    final DocumentSnapshot doc =
        await _firestore.collection('users').doc(uid).get();
    final User? user =
        doc.exists ? User(uid: doc.id, username: doc.get('username')) : null;

    return user;
  }
}
