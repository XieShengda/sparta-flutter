import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/beans/requset/req_login.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/res/colors.dart';

class LoginContentForm extends StatefulWidget {
  final Store<AppState> store;

  LoginContentForm({Key key, this.store}) : super(key: key);

  @override
  _LoginContentFormState createState() => _LoginContentFormState();
}

class _LoginContentFormState extends State<LoginContentForm> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          const SizedBox(height: 80.0),
          Column(
            children: <Widget>[
              Image.asset('assets/images/diamond.png'),
              const SizedBox(height: 16.0),
              Text(
                'Sparta'.toUpperCase(),
                style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
          const SizedBox(height: 120.0),
          AccentColorOverride(
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
          ),
          const SizedBox(height: 12.0),
          AccentColorOverride(
            color: kShrineBrown900,
            child: TextFormField(
              controller: _passwordController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'please enter password';
                }
                if (RegExp('[^(0-9a-zA-Z)]').hasMatch(value)) {
                  return '只能输入数字和字母';
                }
                return null;
              },
            ),
          ),
          Wrap(
            children: <Widget>[
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
                      if (_formKey.currentState.validate()) {
                        widget.store.dispatch(ReqLoginAction(ReqLogin(
                            _mobileController.text, _passwordController.text)));
                      }
                    },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
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
