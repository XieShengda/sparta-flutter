import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/core/redux/common/common_action.dart';
import 'package:sparta/res/colors.dart';
import 'package:sparta/ui/animation/animation/home.dart';
import 'package:sparta/ui/boot/boot_page.dart';
import 'package:sparta/ui/common/utils/router.dart';
import 'package:sparta/ui/common/widgets/cut_corners_border.dart';
import 'package:sparta/ui/home/home_page.dart';
import 'package:sparta/ui/login/login_page.dart';

import 'core/models/enum/auth_status.dart';
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
//        home: SpartaStore.global.state.authState.authStatus == AuthStatus.login
//            ? AnimationDemoHome()
//            : LoginPage(),
        routes: _getRoutes(),
        onGenerateRoute: _onGenerateRoute,
        theme: _spartaTheme.copyWith(platform: Theme.of(context).platform),
      ),
    );
  }



//  ThemeData _buildSpartaTheme() {
//    final ThemeData base = ThemeData.light();
//    return base.copyWith(
//      accentColor: kShrineBrown900,
//      primaryColor: kShrinePink100,
//      scaffoldBackgroundColor: kShrineBackgroundWhite,
//      cardColor: kShrineBackgroundWhite,
//      textSelectionColor: kShrinePink100,
//      errorColor: kShrineErrorRed,
//      buttonTheme: base.buttonTheme.copyWith(
//        buttonColor: kShrinePink100,
//        textTheme: ButtonTextTheme.normal,
//      ),
//      primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
//      inputDecorationTheme: InputDecorationTheme(
//        border: CutCornersBorder(),
//      ),
//      textTheme: _buildSpartaTextTheme(base.textTheme),
//      primaryTextTheme: _buildSpartaTextTheme(base.primaryTextTheme),
//      accentTextTheme: _buildSpartaTextTheme(base.accentTextTheme),
//      iconTheme: _customIconTheme(base.iconTheme),
//    );
//  }
//
//  TextTheme _buildSpartaTextTheme(TextTheme base) {
//    return base
//        .copyWith(
//          headline: base.headline.copyWith(
//            fontWeight: FontWeight.w500,
//          ),
//          title: base.title.copyWith(fontSize: 18.0),
//          caption: base.caption.copyWith(
//            fontWeight: FontWeight.w400,
//            fontSize: 14.0,
//          ),
//          body2: base.body2.copyWith(
//            fontWeight: FontWeight.w500,
//            fontSize: 16.0,
//          ),
//        )
//        .apply(
//          fontFamily: 'Rubik',
//          displayColor: kShrineBrown900,
//          bodyColor: kShrineBrown900,
//        );
//  }

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

final ThemeData _spartaTheme = _buildTheme(ThemeData.light());

ThemeData _buildTheme(ThemeData base) {
  return base.copyWith(
    primaryColor: spartaPrimary,
    primaryColorDark: spartaDarkPrimary,
    primaryColorLight: spartaLightPrimary,
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith();
}

//final ThemeData _kShrineTheme = _buildShrineTheme();
//
//IconThemeData _customIconTheme(IconThemeData original) {
//  return original.copyWith(color: kShrineBrown900);
//}
//
//ThemeData _buildShrineTheme() {
//  final ThemeData base = ThemeData.light();
//  return base.copyWith(
//    colorScheme: kShrineColorScheme,
//    accentColor: kShrineBrown900,
//    primaryColor: kShrinePink100,
//    buttonColor: kShrinePink100,
//    scaffoldBackgroundColor: kShrineErrorRed,
//    cardColor: kShrineBackgroundWhite,
//    textSelectionColor: kShrinePink100,
//    errorColor: kShrineErrorRed,
//    buttonTheme: const ButtonThemeData(
//      colorScheme: kShrineColorScheme,
//      textTheme: ButtonTextTheme.normal,
//    ),
//    primaryIconTheme: _customIconTheme(base.iconTheme),
//
//    ///文本域主题
//    inputDecorationTheme: const InputDecorationTheme(
////      border: UnderlineInputBorder(),
////      border: CutCornersBorder(),
//      border: InputBorder.none,
//    ),
//    textTheme: _buildShrineTextTheme(base.textTheme),
//    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//    iconTheme: _customIconTheme(base.iconTheme),
//  );
//}
//
//TextTheme _buildShrineTextTheme(TextTheme base) {
//  return base
//      .copyWith(
//        headline: base.headline.copyWith(fontWeight: FontWeight.w500),
//        title: base.title.copyWith(fontSize: 18.0),
//        caption:
//            base.caption.copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
//        body2: base.body2.copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
//        button:
//            base.button.copyWith(fontWeight: FontWeight.w500, fontSize: 14.0),
//      )
//      .apply(
//        fontFamily: 'Raleway',
//        displayColor: kShrineBrown900,
//        bodyColor: kShrineBrown900,
//      );
//}
//
//const ColorScheme kShrineColorScheme = ColorScheme(
//  primary: kShrinePink100,
//  primaryVariant: kShrineBrown900,
//  secondary: kShrinePink50,
//  secondaryVariant: kShrineBrown900,
//  surface: kShrineSurfaceWhite,
//  background: kShrineBackgroundWhite,
//  error: kShrineErrorRed,
//  onPrimary: kShrineBrown900,
//  onSecondary: kShrineBrown900,
//  onSurface: kShrineBrown900,
//  onBackground: kShrineBrown900,
//  onError: kShrineSurfaceWhite,
//  brightness: Brightness.light,
//);
//IconThemeData _customIconTheme(IconThemeData original) {
//  return original.copyWith(color: kShrineBrown900);
//}