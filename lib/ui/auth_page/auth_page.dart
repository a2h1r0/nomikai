import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/ui/app.dart';
import 'package:nomikai/ui/auth_page/auth_view_model.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameTextController = TextEditingController();
    final emailTextController = TextEditingController();

    final authMemoize = useMemoized(() => getAuthData(ref));
    final snapshot = useFuture(authMemoize);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Text('読み込み中です．．．',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }

    User? user = snapshot.data;
    if (user == null) {
      return const Text('ユーザーが見つかりませんでした．．．',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
    }

    usernameTextController.text = user.username;
    emailTextController.text = user.email;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                controller: usernameTextController,
                decoration: const InputDecoration(labelText: 'ユーザー名'),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(labelText: 'メールアドレス'),
              )),
          ButtonTheme(
            minWidth: 350.0,
            child: ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);

                final result = await logout(ref);

                if (result == FirebaseAuthResultStatus.successful) {
                  navigator.push(
                      MaterialPageRoute(builder: (context) => const App()));
                }
              },
              child: const Text(
                'ログアウト',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
