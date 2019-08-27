import 'package:meta/meta.dart';
import 'package:sparta/core/redux/auth/auth_state.dart';

@immutable
class AppState {
  AppState({this.authState});

  final AuthState authState;

  factory AppState.initial() => AppState(authState: AuthState.initial());
}
