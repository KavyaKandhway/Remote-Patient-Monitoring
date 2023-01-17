import 'package:flutter/material.dart';
import 'package:remote_patient_monitoring/login.dart';
import 'package:remote_patient_monitoring/loginnew.dart';
import 'package:remote_patient_monitoring/signup.dart';
import 'package:remote_patient_monitoring/signupnew.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginScreen4(onClickedSignUp: toggle)
      : SignUpScreen4(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
