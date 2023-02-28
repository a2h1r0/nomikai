import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nomikai/model/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _userFromFirebaseDocument(dynamic doc) {
    return doc != null
        ? User(
            uid: doc.id, username: doc.get('username'), email: doc.get('email'))
        : null;
  }

  Future<List<User?>> getUserList() async {
    final QuerySnapshot snapshot = await _firestore.collection('users').get();
    final List<User?> users =
        snapshot.docs.map(_userFromFirebaseDocument).toList();

    return users;
  }

  Future<User?> getUser(String uid) async {
    final DocumentSnapshot doc =
        await _firestore.collection('users').doc(uid).get();
    final User? user = _userFromFirebaseDocument(doc);

    return user;
  }

  Future<User?> getUserByPhoneNumber(String phoneNumber) async {
    final QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: phoneNumber)
        .limit(1)
        .get();
    final QueryDocumentSnapshot? doc =
        snapshot.size != 0 ? snapshot.docs[0] : null;
    final User? user = _userFromFirebaseDocument(doc);

    return user;
  }
}
