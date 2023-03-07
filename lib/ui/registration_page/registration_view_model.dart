import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/const/firebase_auth_result.dart';
import 'package:nomikai/service/auth_service.dart';

AutoDisposeStateProvider<bool> isObscureProvider =
    StateProvider.autoDispose((ref) => true);
AutoDisposeStateProvider<String> errorMessageProvider =
    StateProvider.autoDispose((ref) => '');

void toggleObscure(WidgetRef ref) {
  ref.watch(isObscureProvider.notifier).state =
      !ref.watch(isObscureProvider.notifier).state;
}

Future<FirebaseAuthResultStatus> register(
    WidgetRef ref, String email, String password) async {
  final FirebaseAuthResultStatus result =
      await AuthService().registerWithEmailAndPassword(email, password);

  if (result != FirebaseAuthResultStatus.successful) {
    ref.watch(errorMessageProvider.notifier).state =
        FirebaseAuthResult().exceptionMessage(result);
  }

  return result;
}
