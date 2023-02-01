import 'package:flutter/material.dart';
import 'package:nomikai/model/app_user.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/home_page/home_page.dart';
import 'package:nomikai/ui/login_page/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final UserService _auth = UserService();

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
                  try {
                    final navigator = Navigator.of(context);
                    AppUser? user = await _auth.registerWithEmailAndPassword(
                        email, password);

                    if (user != null) {
                      navigator.push(MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage(),
                      ));
                    } else {
                      setState(() {
                        message = '新規登録に失敗しました．．．';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      message = e.toString();
                    });
                  }
                },
                child: const Text(
                  '新規登録',
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
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              },
              child: const Text(
                'ログインする',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}