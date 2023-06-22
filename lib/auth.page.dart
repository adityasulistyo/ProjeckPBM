import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart' as puasaAuth;
import './home_page.dart';
import 'account.dart';

const users = {
  'tester@test.com': '12345',
  'dor@dor.com': '54321',
};

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUserSignUp(LoginData data) async {
    print('Name: ${data.name}, Password ${data.password}');
    await Future.delayed(loginTime);
    Provider.of<puasaAuth.Auth>(context, listen: false)
        .signup(data.name, data.password);
    return null;
  }

  Future<String?> _authUserLogin(LoginData data) async {
    print('Name: ${data.name}, Password ${data.password}');
    await Future.delayed(loginTime);
    Provider.of<puasaAuth.Auth>(context, listen: false)
        .login(data.name, data.password);
    return null;
  }

  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password ${data.password}');
    await Future.delayed(loginTime);
    if (!users.containsKey(data.name)) {
      return 'Username not exists';
    }
    if (users[data.name] != data.password) {
      return 'Password does not match';
    }
    return null;
  }

  Future<String?> _recoverPassword(String name) async {
    print('Name: $name');
    await Future.delayed(loginTime);
    if (!users.containsKey(name)) {
      return 'Username not exists';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'LOGIN',
      onLogin: _authUserLogin,
      onSignup: (SignupData data) async {
        return await _authUserSignUp(
            LoginData(name: data.name!, password: data.password!));
      },
      onSubmitAnimationCompleted: () {
        final authProvider =
            Provider.of<puasaAuth.Auth>(context, listen: false);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AccountPage(email: authProvider.email ?? ''),
          // builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
