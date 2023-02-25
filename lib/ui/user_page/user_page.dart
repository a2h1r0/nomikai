import 'package:flutter/material.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

class UserPage extends StatefulWidget {
  final String username;
  const UserPage({super.key, required this.username});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: UserService().getUser(widget.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('読み込み中です．．．',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }

          User? user = snapshot.data;
          if (user == null) {
            return const Text('ユーザーが見つかりませんでした．．．',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }

          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${user.username}のページです',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        });
  }
}
