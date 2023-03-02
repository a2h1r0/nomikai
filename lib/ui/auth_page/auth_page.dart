import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/auth.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/app.dart';
import 'package:nomikai/ui/auth_page/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameTextController = TextEditingController();
    final emailTextController = TextEditingController();

    return FutureBuilder<User?>(
        future: UserService().getUser(context.watch<Auth?>()!.uid),
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
                        navigator.push(MaterialPageRoute(
                            builder: (context) => const App()));
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
        });
  }
}
