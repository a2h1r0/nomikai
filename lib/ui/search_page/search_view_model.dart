import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

StateProvider<User?> userProvider = StateProvider((ref) => null);

Future<void> getUserByPhoneNumber(WidgetRef ref, String phoneNumber) async {
  User? user = await UserService().getUserByPhoneNumber(phoneNumber);

  ref.watch(userProvider.notifier).state = user;
}
