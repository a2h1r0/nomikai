import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nomikai/model/app_user.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/home_page/home_page.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'ui/login_page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
          value: UserService().user,
          initialData: null,
        )
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: StreamBuilder<AppUser?>(
          stream: UserService().user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            if (snapshot.hasData) {
              // ログイン済
              return const HomePage();
            }

            return const LoginPage();
          }),
    );
  }
}
