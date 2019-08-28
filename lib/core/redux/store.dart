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

  static KeyValueStore keyValueStore;

  ///需要在runApp执行
  static Future<void> init() async {
    keyValueStore = FlutterKeyValueStore(await SharedPreferences.getInstance());
  }

  static dispatch(action) {
    global.dispatch(action);
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
