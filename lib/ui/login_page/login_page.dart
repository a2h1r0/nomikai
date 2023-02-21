import 'package:flutter/material.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/ui/home_page/home_page.dart';
import 'package:nomikai/ui/registration_page/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String message = '';
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    email = value;
                  },
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'パスワード',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )),
                obscureText: _isObscure,
                maxLength: 20,
                onChanged: (String value) {
                  password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child: Text(
                message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            ButtonTheme(
              minWidth: 350.0,
              child: ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final FirebaseAuthResultStatus result =
                      await _auth.loginWithEmailAndPassword(email, password);

                  if (result == FirebaseAuthResultStatus.successful) {
                    navigator.push(MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage(),
                    ));
                  } else {
                    setState(() {
                      message = FirebaseAuthResult().exceptionMessage(result);
                    });
                  }
                },
                child: const Text(
                  'ログイン',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonTheme(
            minWidth: 350.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const RegistrationPage(),
                  ),
                );
              },
              child: const Text(
                'アカウントを作成する',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
