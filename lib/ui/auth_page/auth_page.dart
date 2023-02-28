import 'package:flutter/material.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/auth.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/app.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _auth = AuthService();

  String username = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
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

          username = user.username;
          email = user.email;

          return Scaffold(
            body: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                    child: TextFormField(
                      initialValue: username,
                      decoration: const InputDecoration(labelText: 'ユーザー名'),
                      onChanged: (String value) {
                        username = value;
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                    child: TextFormField(
                      initialValue: email,
                      decoration: const InputDecoration(labelText: 'メールアドレス'),
                      onChanged: (String value) {
                        email = value;
                      },
                    )),
                ButtonTheme(
                  minWidth: 350.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final FirebaseAuthResultStatus result =
                          await _auth.logout();

                      if (result == FirebaseAuthResultStatus.successful) {
                        navigator.push(MaterialPageRoute(
                          builder: (BuildContext context) => const App(),
                        ));
                      } else {
                        String message =
                            FirebaseAuthResult().exceptionMessage(result);
                        print(message);
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
