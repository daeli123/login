import 'package:firebase_auth/firebase_auth.dart';

class AuthHandler {
  final String email;
  final String password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthHandler({
    this.email = "",
    this.password = ""
  });

  Future<Map<String, dynamic>> signIn() async {
    try {
      final res = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );

      return {
        "isvalid": true,
        "data": res.user
      };
    } catch (err) {
      return {
        "isvalid": false,
        "data": err.message
      };
    }
  }

  Future<Map<String, dynamic>> register() async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      await res.user.sendEmailVerification();

      return {
        "isvalid": true,
        "data": res.user,
      };
    } catch (err) {
      return {
        "isvalid": false,
        "data": err.message,
      };
    }
  }
}
