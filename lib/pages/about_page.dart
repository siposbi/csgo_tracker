import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text =
        'SIGN OUT ${context.read<AuthenticationService>().currentUser!.displayName}';
    final text2 =
        '${context.read<AuthenticationService>().currentUser!.metadata.creationTime}';
    final text4 = '${context.read<AuthenticationService>().currentUser!.email}';

    return Column(
      children: [
        SizedBox(
          width: 115,
          height: 115,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                context.read<AuthenticationService>().currentUser!.photoURL!),
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton(
          child: Text(text),
          onPressed: () => context.read<AuthenticationService>().signOut(),
        ),
      ],
    );
  }
}
