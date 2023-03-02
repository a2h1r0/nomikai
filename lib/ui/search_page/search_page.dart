import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/ui/search_page/search_view_model.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchTextController = TextEditingController();

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
                      controller: searchTextController,
                      decoration: const InputDecoration(
                        hintText: 'Search Text',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.clear),
                        contentPadding: EdgeInsets.only(left: 8.0),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                      ),
                      onChanged: (phoneNumber) async {
                        getUserByPhoneNumber(ref, searchTextController.text);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          HookConsumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final user = ref.watch(userProvider);

            if (user != null) {
              return Text('${user.username} のページです．',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold));
            }

            return const Text('ユーザーが見つかりません．．．',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }),
        ],
      ),
    );
  }
}
