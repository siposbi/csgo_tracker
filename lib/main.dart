import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/pages/sign_in/sign_in_page.dart';
import 'package:csgo_tracker/pages/tabs_page.dart';
import 'package:csgo_tracker/services/authentication_service.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        Provider<CustomColors>(
          create: (_) => CustomColors(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        Provider<DatabaseService>(
          create: (context) =>
              DatabaseService(FirebaseFirestore.instance, context),
        ),
      ],
      child: MaterialApp(
        title: 'Mm Tracker',
        theme: ThemeData(
          primarySwatch: CustomColors.PRIMARY_SWATCH,
          scaffoldBackgroundColor: CustomColors.BACKGROUND_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return TabsPage();
    }
    return SignInPage();
  }
}
