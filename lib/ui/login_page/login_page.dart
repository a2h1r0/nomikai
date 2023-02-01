import 'package:flutter/material.dart';
import 'package:nomikai/model/app_user.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/home_page/home_page.dart';
import 'package:nomikai/ui/registration_page/registration_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserService _auth = UserService();

  String email = '';
  String password = '';
  String message = '';
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user != null) {
      // todo: リダイレクトでないが問題ない？
      return const HomePage();
    }

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
                    AppUser? user =
                        await _auth.loginWithEmailAndPassword(email, password);

                    if (user != null) {
                      navigator.push(MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage(),
                      ));
                    } else {
                      setState(() {
                        message = 'ユーザが見つかりませんでした．．．';
                      });
                    }
                  } catch (e) {
                    setState(() {
                      message = e.toString();
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
