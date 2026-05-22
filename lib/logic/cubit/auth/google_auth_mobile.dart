import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'google_auth_service.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  @override
  Future<void> init() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      // Already initialized or platform doesn't support
    }
  }

  @override
  Future<AuthCredential?> getGoogleCredential() async {
    try {
      // Force account picker by signing out first if needed, 
      // or just call signIn() which shows picker if multiple accounts exist.
      // To ALWAYS show picker, we can use:
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      return GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    } catch (e) {
      print("Google Sign In Error: $e");
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}

GoogleAuthService getGoogleService() => GoogleAuthServiceImpl();
