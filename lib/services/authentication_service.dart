import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result =
        await _firebaseAuth.signInWithCredential(credential);


    if (result.additionalUserInfo!.isNewUser){
      User? user = result.user;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'displayName': user.displayName,
        'email': user.email,
      });
    }

    return result;
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }
}
