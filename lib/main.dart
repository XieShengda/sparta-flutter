import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/core/redux/common/common_action.dart';
import 'package:sparta/res/colors.dart';
import 'package:sparta/res/dimens.dart';
import 'package:sparta/ui/boot/boot_page.dart';
import 'package:sparta/ui/common/utils/router.dart';
import 'package:sparta/ui/home/home_page.dart';
import 'package:sparta/ui/login/login_page.dart';

import 'core/redux/store.dart';

Future<void> main() async {
  ///初始化微信sdk
//  fluwx.register(appId: FluwxConfig.APP_ID);
  WidgetsFlutterBinding.ensureInitialized();
  await SpartaStore.init();
  runApp(SpartaApp());
}

class SpartaApp extends StatefulWidget {
  @override
  _SpartaAppState createState() => _SpartaAppState();
}

class _SpartaAppState extends State<SpartaApp> {
  @override
  void initState() {
    super.initState();
    SpartaStore.global.dispatch(InitAction());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: SpartaStore.global,
      child: MaterialApp(
        title: "Sparta",
        home: BootPage(),
//通过接口调用的结果来判断，而不是页面
//        home: SpartaStore.global.state.authState.authStatus == AuthStatus.login
//            ? AnimationDemoHome()
//            : LoginPage(),
        routes: _getRoutes(),
        onGenerateRoute: _onGenerateRoute,
        theme: _spartaTheme.copyWith(platform: Theme.of(context).platform),
      ),
    );
  }

  ///已经注册的命名路由不经过此方法
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    // todo 注册页面不跳转
    //todo 游客模式需要判断
/*    if (settings.name != '/login' ||
        SpartaStore.global.state.authState.authStatus != AuthStatus.login) {
      page = LoginPage();
    }*/

    return MaterialPageRoute(
      builder: (context) {
        debugPrint(settings.name);
        return HomePage();
      },
    );
  }

  Map<String, Widget Function(BuildContext)> _getRoutes() {
    return {
      Router.home: (BuildContext context) => HomePage(),
      Router.login: (BuildContext context) => LoginPage(),
    };
  }
}


///配置主题
final ThemeData _spartaTheme = _buildTheme(ThemeData.light());

ThemeData _buildTheme(ThemeData base) {
  return base.copyWith(
    primaryColor: spartaPrimary,
    primaryColorDark: spartaDarkPrimary,
    primaryColorLight: spartaLightPrimary,
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    scaffoldBackgroundColor: spartaDarkPrimary,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(fontWeight: FontWeight.w600,fontSize: fontTitle, color: spartaWhite),
    body1: base.title.copyWith(fontWeight: FontWeight.w500, fontSize: fontBody1, color: spartaDarkPrimary),
    body2: base.title.copyWith(fontWeight: FontWeight.w500, fontSize: fontBody2,color: spartaDarkPrimary),


  );
}
