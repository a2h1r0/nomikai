import 'package:flutter/material.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: SizedBox(
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Container(
                    width: 340,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Search Text',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.clear),
                        contentPadding: EdgeInsets.only(left: 8.0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                      ),
                      onSubmitted: (phoneNumber) async {
                        User? data = await UserService()
                            .getUserByPhoneNumber(phoneNumber);
                        setState(() {
                          user = data;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text('${user?.username} のページです．',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
