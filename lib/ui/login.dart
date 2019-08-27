import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/beans/requset/req_login.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/res/colors.dart';

import 'common/platform_adaptive_progress_indicator.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => StoreConnector(
          onDidChange: (Store<AppState> store) {
            //todo navigator
            if (store.state.authState.requestStatus[AuthRequestType.login] ==
                LoadingStatus.error) {
              Scaffold.of(context)
                  .showSnackBar(new SnackBar(content: Text('login error')));
            }
          },
          converter: (Store<AppState> store) => store,
          builder: (BuildContext context, Store<AppState> store) => Stack(
            children: <Widget>[
              _buildLoginPage(context, store),
              _buildLoadingView(store)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView(Store<AppState> store) {
    return store.state.authState.requestStatus[AuthRequestType.login] ==
            LoadingStatus.loading
        ? Container(
            alignment: Alignment.center,
            color: Color.fromARGB(128, 0, 0, 100),
            child: PlatformAdaptiveProgressIndicator())
        : Container();
  }

  Widget _buildLoginPage(BuildContext context, Store<AppState> store) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 80.0),
          Column(
            children: <Widget>[
              Image.asset('assets/diamond.png'),
              SizedBox(height: 16.0),
              Text(
                'Sparta'.toUpperCase(),
                style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
          SizedBox(height: 120.0),
          AccentColorOverride(
            color: kShrineBrown900,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
          SizedBox(height: 12.0),
          AccentColorOverride(
            color: kShrineBrown900,
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {},
              ),
              RaisedButton(
                child: Text('NEXT'),
                elevation: 8.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {
                  //todo text valid
                  store.dispatch(ReqLoginAction(ReqLogin(
                      _usernameController.text, _passwordController.text)));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
