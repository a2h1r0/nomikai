import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/service/auth_service.dart';

StateProvider<bool> isObscureProvider = StateProvider((ref) => true);
StateProvider<String> errorMessageProvider = StateProvider((ref) => '');

void toggleObscure(WidgetRef ref) {
  ref.watch(isObscureProvider.notifier).state =
      !ref.watch(isObscureProvider.notifier).state;
}

Future<FirebaseAuthResultStatus> login(
    WidgetRef ref, String email, String password) async {
  final FirebaseAuthResultStatus result =
      await AuthService().loginWithEmailAndPassword(email, password);

  if (result != FirebaseAuthResultStatus.successful) {
    ref.watch(errorMessageProvider.notifier).state =
        FirebaseAuthResult().exceptionMessage(result);
  }

  return result;
}
