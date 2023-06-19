import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login with Username and Password',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add logic to handle login with username and password
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Or login with',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Add logic to handle login with Google
                    },
                    icon: Icon(Icons.login),
                    tooltip: 'Login with Google',
                  ),
                  IconButton(
                    onPressed: () {
                      // Add logic to handle login with Facebook
                    },
                    icon: Icon(Icons.login),
                    tooltip: 'Login with Facebook',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
