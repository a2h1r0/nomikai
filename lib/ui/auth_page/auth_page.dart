import 'package:flutter/material.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/auth.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/ui/app.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final String authId = context.watch<Auth?>()!.uid;

    return Scaffold(
      body: Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 350.0,
            child: ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final FirebaseAuthResultStatus result = await _auth.logout();

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
          Text('ようこそ $authId',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
