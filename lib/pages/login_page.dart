import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../components/ti_component.dart';
import 'package:login/stores/user_store.dart';
import 'package:login/handlers/auth_handler.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore = Injector.getAsReactive<UserStore>(context: context);

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TiComponent(
              label: "Email",
              hint: "user@contoh.com",
              keyboardType: TextInputType.emailAddress,
              validate: (String value) {
                if (value.isEmpty) {
                  return "Email diperlukan";
                } else if (!EmailValidator.validate(value)) {
                  return "Email tidak valid";
                }else {
                  return null;
                }
              },
              change: (String value) {
                email = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TiComponent(
              label: "Password",
              hint: "Kata kunci",
              isPassword: true,
              validate: (String value) {
                if (value.isEmpty) {
                  return "Password diperlukan";
                } else {
                  return null;
                }
              },
              change: (String value) {
                password = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "MASUK",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  color: Colors.lightBlue,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final AuthHandler _auth = AuthHandler(
                        email: email,
                        password: password
                      );

                      final Map<String, dynamic> status = await _auth.signIn();

                      if (status["isvalid"]) {
                        _userStore.setState((state) => state.setLogStatus(true));
                      } else {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(status["data"]),
                          )
                        );
                      }
                    }
                  },
                ),
                FlatButton(
                  child: Text(
                    "Pengguna baru?",
                    style: TextStyle(
                      color: Colors.black45
                    ),
                  ),
                  onPressed: () {
                    _userStore.setState((state) => state.setRegisterStatus(true));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
