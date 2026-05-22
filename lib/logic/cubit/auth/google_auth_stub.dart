import 'google_auth_service.dart';

class GoogleAuthServiceImpl implements GoogleAuthService {
  @override
  Future<void> init() async {}

  @override
  Future<dynamic> getGoogleCredential() async {
    // Simulate a short delay then return a mock credential for Windows
    await Future.delayed(const Duration(seconds: 1));
    return "win_user";
  }

  @override
  Future<void> signOut() async {}
}

GoogleAuthService getGoogleService() => GoogleAuthServiceImpl();
