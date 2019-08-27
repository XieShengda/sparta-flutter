import 'package:sparta/core/redux/auth/auth_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
  );
}
