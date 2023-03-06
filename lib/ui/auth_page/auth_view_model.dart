import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/auth_service.dart';
import 'package:nomikai/service/user_service.dart';

Future<User?> getAuthData(WidgetRef ref) async {
  final auth = await ref.watch(authStreamProvider.future);

  User? user = await UserService().getUser(auth!.uid);

  return user;
}

Future<FirebaseAuthResultStatus> logout(WidgetRef ref) async {
  final FirebaseAuthResultStatus result = await AuthService().logout();

  return result;
}
