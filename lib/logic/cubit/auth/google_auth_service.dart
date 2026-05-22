abstract class GoogleAuthService {
  Future<void> init();
  Future<dynamic> getGoogleCredential(); // dynamic instead of AuthCredential
  Future<void> signOut();
}
