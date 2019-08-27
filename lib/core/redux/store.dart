import 'package:key_value_store/key_value_store.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparta/core/networking/auth_api.dart';

import 'app/app_reducer.dart';
import 'app/app_state.dart';
import 'auth/auth_middleware.dart';

class SpartaStore {
  static final Store<AppState> global = createStore();

  static dispatch(action) {
    global.dispatch(action);
  }

  static KeyValueStore _keyValueStore;

  static Future<KeyValueStore> getKeyValueStore() async {
    if (_keyValueStore == null) {
      _keyValueStore =
          FlutterKeyValueStore(await SharedPreferences.getInstance());
    }
    return _keyValueStore;
  }
}

Store<AppState> createStore() {
  final authApi = AuthApi();
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: [AuthMiddleWare(authApi)],
    distinct: true,
  );
}
