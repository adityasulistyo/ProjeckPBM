import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _email;

  String? get email => _email;
  void signup(String email, String password) async {
    _email = email; // Simpan email yang berhasil di-signup
    notifyListeners();
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAbJFNPuwTq7Bgyw0D-VKUu2fl8ybLYUaM');
    var response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    print(json.decode(response.body));
  }

  void login(String email, String password) async {
    _email = email; // Simpan email yang berhasil di-login
    notifyListeners();
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAbJFNPuwTq7Bgyw0D-VKUu2fl8ybLYUaM');
    var response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    print(json.decode(response.body));
  }
}
