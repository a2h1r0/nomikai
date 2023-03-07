import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/ui/user_page/user_view_model.dart';

class UserPage extends HookConsumerWidget {
  final String username;
  const UserPage({super.key, required this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userProvider(username)).when(data: ((User? user) {
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
    }), error: ((error, stackTrace) {
      // todo: error message
      return const Text('読み込みに失敗しました．．．',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }), loading: (() {
      return const Text('読み込み中です．．．',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }));
  }
}
