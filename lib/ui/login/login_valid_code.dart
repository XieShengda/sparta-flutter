import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/beans/requset/req_login_by_code.dart';
import 'package:sparta/core/models/beans/requset/req_sms.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/models/enum/sms_type.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/res/colors.dart';
import 'package:sparta/ui/common/snack_bar.dart';

class LoginValidCode extends StatefulWidget {
  final Store<AppState> store;

  LoginValidCode({Key key, this.store}) : super(key: key);

  @override
  _LoginValidCodeState createState() => _LoginValidCodeState();
}

class _LoginValidCodeState extends State<LoginValidCode> {
  final _mobileController = TextEditingController();
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer _timer;
  int _countdownTime = 0;

  _startCountDownTimer() {
    _countdownTime = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownTime < 1) {
        timer.cancel();
      } else {
        setState(() {
          _countdownTime -= 1;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ///build
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onDidChange: (store) {
        switch (store.state.authState.requestStatus[AuthRequestType.sms]) {
          case LoadingStatus.error:
            SnackBarShower.text(context,
                store.state.authState.error[AuthRequestType.sms].message);
            break;
          case LoadingStatus.success:
            SnackBarShower.text(context, '验证码发送成功');
            _startCountDownTimer();
            store.dispatch(SmsInitAction());
            break;
          default:
        }
      },
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store<AppState> store) => SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),

              ///Logo
              buildLogo(context),
              const SizedBox(height: 120.0),

              ///手机号输入框
              buildPhoneField(),
              const SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ///验证码输入框
                  buildValidCodeField(store),
                  SizedBox(
                    width: 20,
                  ),

                  ///获取验证码
                  buildValidCodeButton(context, store),
                ],
              ),

              ///登录按钮
              buildButtonBar(store)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/diamond.png'),
        const SizedBox(height: 16.0),
        Text(
          'Sparta'.toUpperCase(),
          style: Theme.of(context).textTheme.headline,
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return AccentColorOverride(
      color: kShrineBrown900,
      child: TextFormField(
        controller: _mobileController,
        maxLines: 1,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.isEmpty) {
            return 'please enter phone';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Phone',
        ),
      ),
    );
  }

  Widget buildValidCodeButton(BuildContext context, Store<AppState> store) {
    return GestureDetector(
      child: Text(
        _countdownTime > 0 ? '$_countdownTime秒后重新获取' : '获取验证码',
        style: TextStyle(
          fontSize: 14,
          color: _countdownTime > 0 ? kShrinePink100 : kShrineBrown900,
        ),
      ),
      onTap: () {
        if (_countdownTime > 0) {
          return;
        }
        if (_mobileController.text.isEmpty) {
          SnackBarShower.text(context, '手机号为空');
          return;
        }
        if (!RegExp(r'^1[0-9]{10}$').hasMatch(_mobileController.text)) {
          SnackBarShower.text(context, '手机号格式错误');
          return;
        }
        store.dispatch(ReqSmsAction(
          ReqSms(mobile: _mobileController.text, type: SmsType.login),
        ));
      },
    );
  }

  Widget buildValidCodeField(Store<AppState> store) {
    return AccentColorOverride(
      color: kShrineBrown900,
      child: Expanded(
        child: TextFormField(
          onFieldSubmitted: (value) {
            doLogin(store);
          },
          textInputAction: TextInputAction.go,
          controller: _codeController,
          maxLines: 1,
          decoration: InputDecoration(
            labelText: 'Valid Code',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'please enter valid code';
            }
            if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
              return '验证码为6位数字';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget buildButtonBar(Store<AppState> store) {
    return Wrap(
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              onPressed: () {
                _formKey.currentState.reset();
              },
            ),
            RaisedButton(
              child: Text('NEXT'),
              elevation: 8.0,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              onPressed: () {
                doLogin(store);
              },
            ),
          ],
        ),
      ],
    );
  }

  void doLogin(Store<AppState> store) {
    if (_formKey.currentState.validate()) {
      widget.store.dispatch(ReqLoginByCodeAction(ReqLoginByCode(
        mobile: _mobileController.text,
        validCode: _codeController.text,
        msgId: store.state.authState.smsInfo.msgId,
      )));
    }
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
