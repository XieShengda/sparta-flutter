import 'package:sparta/core/models/beans/auth_info.dart';

class InitAction {}

class InitCompleteAction {
  final AuthInfo authInfo;

  InitCompleteAction({this.authInfo});
}
