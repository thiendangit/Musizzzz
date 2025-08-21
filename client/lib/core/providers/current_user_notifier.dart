import 'package:client/features/auth/models/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  Auth? build() {
    return null;
  }

  void setAuth(Auth auth) {
    state = auth;
  }

  void clearAuth() {
    state = null;
  }
}
