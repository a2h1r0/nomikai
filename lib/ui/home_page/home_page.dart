import 'package:flutter/material.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/app_user.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/login_page/login_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserService _auth = UserService();

  @override
  Widget build(BuildContext context) {
    String userId = context.watch<AppUser?>()?.uid ?? '名無し';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ようこそ $userId',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ButtonTheme(
              minWidth: 350.0,
              child: ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final FirebaseAuthResultStatus result = await _auth.logout();

                  if (result == FirebaseAuthResultStatus.successful) {
                    navigator.push(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage(),
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
      ),
    );
  }
}
