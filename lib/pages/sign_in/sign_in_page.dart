import 'package:csgo_tracker/materials/show_snackbar.dart';
import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('CS:GO Mm Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sign in to use this app',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 80.0,
              child: ElevatedButton(
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ))),
                onPressed: () async {
                  try {
                    await context
                        .read<AuthenticationService>()
                        .signInWithGoogle();
                    var username = context
                        .read<AuthenticationService>()
                        .currentUser!
                        .displayName;
                    ShowSnackBar.show(
                        context: context,
                        text: 'Signed in as $username');
                  } catch (e) {
                    ShowSnackBar.show(
                        context: context,
                        text: 'Error while signing in $e',
                        backgroundColor: Colors.red);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
