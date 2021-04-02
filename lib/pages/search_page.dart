import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = 'SIGN OUT ${context.read<AuthenticationService>().currentUser!}';

    return Container(
      child: ElevatedButton(
        child: Text(text),
        onPressed: () => context.read<AuthenticationService>().signOut(),
      ),
    );
  }
}
