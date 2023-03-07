import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomikai/model/user.dart';
import 'package:nomikai/service/user_service.dart';

FutureProviderFamily<User?, String> userProvider =
    FutureProvider.family<User?, String>(
        (ref, String username) => UserService().getUser(username));
