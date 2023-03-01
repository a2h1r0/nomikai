import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/ui/app.dart';
import 'package:nomikai/ui/login_page/login_view_model.dart';
import 'package:nomikai/ui/registration_page/registration_page.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    // todo: remove
    emailTextController.text = 'test@test.com';
    passwordTextController.text = 'testtest';

    final isObscure = ref.watch(isObscureProvider);
    final errorMessage = ref.watch(errorMessageProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  controller: emailTextController,
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
              child: TextFormField(
                controller: passwordTextController,
                decoration: InputDecoration(
                    labelText: 'パスワード',
                    suffixIcon: IconButton(
                      icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        toggleObscure(ref);
                      },
                    )),
                obscureText: isObscure,
                maxLength: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            ButtonTheme(
              minWidth: 350.0,
              child: ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);

                  final result = await login(ref, emailTextController.text,
                      passwordTextController.text);

                  if (result == FirebaseAuthResultStatus.successful) {
                    navigator.push(
                        MaterialPageRoute(builder: (context) => const App()));
                  } else {
                    emailTextController.clear();
                    passwordTextController.clear();
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
