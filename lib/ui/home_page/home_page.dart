import 'package:flutter/material.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/auth.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/service/user_service.dart';
import 'package:nomikai/ui/login_page/login_page.dart';
import 'package:nomikai/ui/search_page/search_page.dart';
import 'package:nomikai/ui/user_page/user_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  List<User?> userList = <User?>[];

  @override
  Widget build(BuildContext context) {
    String authId = context.watch<Auth?>()?.uid ?? '名無し';

    return Scaffold(
      body: Column(
        children: <Widget>[
          ButtonTheme(
            minWidth: 350.0,
            child: ElevatedButton(
              onPressed: () async {
                List<User?> users = await UserService().getUserList();
                users.removeWhere((user) => user!.uid == authId);

                setState(() {
                  userList = users;
                });
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
