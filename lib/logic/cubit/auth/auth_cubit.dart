import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_state.dart';
import 'package:biofit_pro/locator.dart';
import 'package:biofit_pro/data/repositories/body_repository.dart';
import 'google_auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth? _auth = (Platform.isAndroid || Platform.isIOS) ? FirebaseAuth.instance : null;
  static late GoogleAuthService googleService;

  AuthCubit() : super(AuthInitial()) {
    // Listen to auth changes only on mobile
    if (_auth != null) {
      _auth!.authStateChanges().listen((User? user) {
        if (user != null) {
          if (user.emailVerified || user.providerData.any((p) => p.providerId == 'google.com')) {
            emit(AuthSuccess(user: user));
          } else {
            emit(AuthNeedsVerification(user.email ?? ""));
          }
        } else {
          emit(AuthInitial());
        }
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      
      // FALLBACK FOR WINDOWS DEV
      if (_auth == null) {
        await Future.delayed(const Duration(seconds: 1));
        emit(const AuthSuccess(user: "windows_dev_user"));
        return;
      }

      final credential = await googleService.getGoogleCredential();

      if (credential == null) {
        emit(AuthInitial());
        return;
      }

      final userCredential = await _auth?.signInWithCredential(credential as AuthCredential);
      emit(AuthSuccess(user: userCredential?.user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInAnonymously({bool persistLocally = false}) async {
    try {
      emit(AuthLoading());
      if (persistLocally) {
        final settings = await locator<BodyRepository>().getUserSettings();
        settings.devPersistLogin = true;
        await locator<BodyRepository>().saveUserSettings(settings);
      }
      emit(const AuthSuccess(user: null, isGuest: true));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      emit(AuthLoading());

      // FALLBACK FOR WINDOWS DEV
      if (_auth == null) {
        await Future.delayed(const Duration(seconds: 1));
        emit(const AuthSuccess(user: "windows_dev_user"));
        return;
      }

      final userCredential = await _auth?.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential?.user;
      if (user != null) {
        if (!user.emailVerified) {
          emit(AuthNeedsVerification(email));
        } else {
          emit(AuthSuccess(user: user));
        }
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Authentication failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      emit(AuthLoading());
      final userCredential = await _auth?.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential?.user;
      if (user != null) {
        await user.sendEmailVerification();
        emit(AuthNeedsVerification(email));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? "Registration failed"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resendVerificationEmail() async {
    final user = _auth?.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> checkEmailVerification() async {
    final user = _auth?.currentUser;
    if (user != null) {
      await user.reload();
      final freshUser = _auth?.currentUser;
      if (freshUser != null && freshUser.emailVerified) {
        emit(AuthSuccess(user: freshUser));
      }
    }
  }

  Future<void> signOut() async {
    try {
      final settings = await locator<BodyRepository>().getUserSettings();
      settings.devPersistLogin = false;
      await locator<BodyRepository>().saveUserSettings(settings);
      
      await googleService.signOut();
      await _auth?.signOut();
    } catch (_) {}
    emit(AuthInitial());
  }

  User? get currentUser => _auth?.currentUser;
}
