import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/auth.dart';
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
          return ref.watch(authProvider).when(data: ((Auth? auth) {
            if (auth == null) {
              // 未ログイン
              return const LoginPage();
            }

            return const AppWidget();
          }), error: ((error, stackTrace) {
            // todo: error logout?
            return const LoginPage();
          }), loading: (() {
            return const SizedBox();
          }));
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
