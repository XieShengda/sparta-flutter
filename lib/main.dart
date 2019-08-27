import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/common/common_action.dart';
import 'package:sparta/res/colors.dart';
import 'package:sparta/ui/common/supplemental/cut_corners_border.dart';
import 'package:sparta/ui/home.dart';
import 'package:sparta/ui/login.dart';

import 'core/models/enum/auth_request_type.dart';
import 'core/redux/app/app_state.dart';
import 'core/redux/store.dart';

Future<void> main() async {
  ///初始化微信sdk
//  fluwx.register(appId: FluwxConfig.APP_ID);

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
        theme: _buildSpartaTheme(),
        home: HomePage(),
        initialRoute: '/login',
        onGenerateRoute: _getRoute,
      ),
    );
  }

  IconThemeData _customIconTheme(IconThemeData original) {
    return original.copyWith(color: kShrineBrown900);
  }

  ThemeData _buildSpartaTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink100,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kShrinePink100,
        textTheme: ButtonTextTheme.normal,
      ),
      primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(),
      ),
      textTheme: _buildSpartaTextTheme(base.textTheme),
      primaryTextTheme: _buildSpartaTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildSpartaTextTheme(base.accentTextTheme),
      iconTheme: _customIconTheme(base.iconTheme),
    );
  }

  TextTheme _buildSpartaTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
          ),
          title: base.title.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          body2: base.body2.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: kShrineBrown900,
          bodyColor: kShrineBrown900,
        );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login' ||
        SpartaStore.global.state.authState.hasLogin) return null;

    return MaterialPageRoute(
        settings: settings,
        builder: (context) => LoginPage(),
        fullscreenDialog: true);
  }
}
