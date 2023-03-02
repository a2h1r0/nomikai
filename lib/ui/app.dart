import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/ui/app_view_model.dart';
import 'package:nomikai/ui/login_page/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HookConsumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final auth = useMemoized(() {
            return AuthService().user;
          });
          final snapshot = useStream(auth);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          if (snapshot.data != null) {
            // ログイン済
            return const AppWidget();
          }

          return const LoginPage();
        },
      ),
    );
  }
}

class AppWidget extends HookConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);
    final page = ref.watch(pageProvider);

    return Scaffold(
        body: page,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (index) {
            togglePage(ref, index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '検索'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        ));
  }
}
