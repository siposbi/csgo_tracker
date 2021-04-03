import 'package:csgo_tracker/materials/custom_card.dart';
import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: CustomColors.PRIMARY_COLOR,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(context
                    .read<AuthenticationService>()
                    .currentUser!
                    .photoURL!),
              ),
            ),
            CustomCard(
                title: 'User:',
                text: context
                    .read<AuthenticationService>()
                    .currentUser!
                    .displayName!),
            CustomCard(
                title: 'Email:',
                text: context.read<AuthenticationService>().currentUser!.email!),
            CustomCard(
                title: 'Registered',
                text: DateFormat('yyyy-MM-dd').format(context
                    .read<AuthenticationService>()
                    .currentUser!
                    .metadata
                    .creationTime!)),
            SizedBox(
              height: 80.0,
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  'Sign out',
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
                    var username = context
                        .read<AuthenticationService>()
                        .currentUser!
                        .displayName;
                    await context.read<AuthenticationService>().signOut();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Signed out as $username',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Error while signing out $e',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ));
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
