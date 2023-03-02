import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/service/auth_service.dart';

Future<FirebaseAuthResultStatus> logout(WidgetRef ref) async {
  final FirebaseAuthResultStatus result = await AuthService().logout();

  return result;
}
