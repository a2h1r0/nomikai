import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nomikai/model/auth.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/ui/app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        StreamProvider<Auth?>.value(
          value: AuthService().user,
          initialData: null,
        )
      ],
      child: const App(),
    ),
  );
}
