import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../pages/login_page.dart';
import 'package:login/pages/register_page.dart';
import 'package:login/stores/user_store.dart';

class AuthLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ReactiveModel<UserStore> _userStore = Injector.getAsReactive<UserStore>(context: context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0,),
          child: _userStore.state.isRegister ? RegisterPage() : LoginPage(),
        ),
      ),
    );
  }
}
