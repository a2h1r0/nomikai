import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

StateProvider<List<User?>> userListProvider = StateProvider((ref) => <User?>[]);

void getUserList(WidgetRef ref) async {
  List<User?> users = await UserService().getUserList();
  // todo
  // String authId = '名無し';
  // users.removeWhere((user) => user!.uid == authId);

  ref.watch(userListProvider.notifier).state = users;
}
