import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_team/pages/login.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return auth.currentUser;
  }

  // ignore: non_constant_identifier_names
  Future SignOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Widget logInScreen() {
    // Trả về màn hình LogIn()
    return LogIn();
  }

  Future deleteuser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}
