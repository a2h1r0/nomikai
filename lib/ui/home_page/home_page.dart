import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/ui/home_page/home_view_model.dart';
import 'package:nomikai/ui/user_page/user_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);

    return Scaffold(
      body: Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 350.0,
            child: ElevatedButton(
              onPressed: () {
                getUserList(ref);
              },
              child: const Text(
                'ユーザー一覧',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              final String username = userList[index]!.username;
              return Container(
                height: 50,
                color: Colors.amber[600],
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserPage(
                                  username: username,
                                )),
                      );
                    },
                    child: Text(username)),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )),
        ],
      ),
    );
  }
}
