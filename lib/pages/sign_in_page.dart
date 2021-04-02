import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signInWithGoogle();
              },
              child: Text("Sign in"),
            ),
          )
        ],
      ),
    );
  }
}
