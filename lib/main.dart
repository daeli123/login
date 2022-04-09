import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import './layouts/auth_layout.dart';
import 'package:login/layouts/app_layout.dart';
import 'package:login/layouts/status_layout.dart';
import 'package:login/stores/user_store.dart';

void main() {
  var inject2 = Inject<FirebaseUser>.future(() async {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final FirebaseUser _user = (await _auth.currentUser) as FirebaseUser;

        return _user;
      });
  var inject = inject2;
  return runApp(
  Injector(
    inject: <Inject>[
      inject,
    ],
    builder: (BuildContext context) {
      final ReactiveModel<FirebaseUser> _userStore = Injector.getAsReactive<FirebaseUser>(context: context);

      return _userStore.whenConnectionState(
        onIdle: () {
          return StatusLayout(
            message: "Init Login App",
          );
        }, 
        onWaiting: () {
          return StatusLayout(
            message: "Loading Login App...",
          );
        }, 
        onError: (err) {
          return StatusLayout(
            message: err.message,
          );
        },
        onData: (FirebaseUser user) {
          return Injector(
            inject: <Inject>[
              Inject<UserStore>(() => UserStore()),
            ],
            builder: (BuildContext context) {
              final ReactiveModel<UserStore> _userStore = Injector.getAsReactive<UserStore>(context: context);

              if (user != null || _userStore.state.loggedIn) {
                return AppLayout();
              }

              return AuthLayout();
            },
          );
        },
      );
    },
  )
);
}

mixin FirebaseUser {
}
