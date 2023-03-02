import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

class UserPage extends HookConsumerWidget {
  final String username;
  const UserPage({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<User?>(
        future: UserService().getUser(username),
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
