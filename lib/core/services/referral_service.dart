import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/repositories/body_repository.dart';
import '../../locator.dart';

/// Handles install-referrer detection and crediting referrers with free AI messages.
///
/// ## How the full referral flow works:
///
/// 1. User A shares their referral link: https://muvio.app/invite?ref=muvio_0_ref
///
/// 2. Friend (User B) taps the link:
///    - On Android: Google Play records the referrer param in its install referrer API.
///    - On iOS: Universal Link / App Clip opens the app with the referral code in the URL.
///
/// 3. On User B's first app launch, this service reads the referral code.
///
/// 4. This service calls YOUR backend (REFERRAL_API_BASE_URL) with User B's device ID
///    and User A's referral code. Your backend:
///      a. Marks User B as "referred" (so the referral can only be used once).
///      b. Finds User A's account and adds 5 free AI messages to their quota.
///
/// 5. On User A's next app open, `syncReferralRewards()` calls the backend and
///    pulls any new free messages they earned.
///
/// ## What you need to set up:
/// - Replace REFERRAL_API_BASE_URL with your actual API endpoint.
/// - Add `play_install_referrer: ^2.0.1` to pubspec.yaml for Android referrer reading.
/// - Handle Universal Links in AppDelegate.swift for iOS referrer reading.
/// - Build a simple backend (Firebase Functions / Supabase Edge Function / etc.)
///   that implements POST /referral/register and GET /referral/rewards?userId=...

class ReferralService {
  // ─── CONFIGURE THIS ────────────────────────────────────────────────────────
  /// Your backend API base URL. Replace before going to production.
  static const String _apiBase = 'https://api.muvio.app';
  // ───────────────────────────────────────────────────────────────────────────

  final BodyRepository _bodyRepo = locator<BodyRepository>();

  /// Called once on app first-launch (after onboarding completes).
  /// Reads the install referrer and notifies the backend so the referrer
  /// gets credited with 5 free AI messages.
  Future<void> processInstallReferral() async {
    try {
      final settings = await _bodyRepo.getUserSettings();

      // Only process the referral once (on very first launch)
      if (settings.hasProcessedReferral) return;

      String? referralCode = await _readInstallReferrer();

      if (referralCode == null || referralCode.isEmpty) {
        // No referral — mark so we don't check again
        settings.hasProcessedReferral = true;
        await _bodyRepo.saveUserSettings(settings);
        return;
      }

      debugPrint('[Referral] Detected referral code: $referralCode');

      // Notify backend — this credits the referrer
      final response = await http
          .post(
            Uri.parse('$_apiBase/referral/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'referral_code': referralCode,
              'new_user_device_id': 'device_${settings.id}',
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('[Referral] Successfully registered referral on backend.');
      } else {
        debugPrint(
          '[Referral] Backend returned ${response.statusCode}: ${response.body}',
        );
      }

      // Mark as processed regardless of backend result
      settings.hasProcessedReferral = true;
      await _bodyRepo.saveUserSettings(settings);
    } catch (e) {
      debugPrint('[Referral] processInstallReferral error: $e');
    }
  }

  /// Called each time the app opens. Checks if the backend has credited
  /// the current user with any new free AI messages (from friends who installed).
  Future<int> syncReferralRewards() async {
    try {
      final settings = await _bodyRepo.getUserSettings();
      final userId = 'device_${settings.id}';

      final response = await http
          .get(Uri.parse('$_apiBase/referral/rewards?userId=$userId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final newMessages = (data['new_free_messages'] as num?)?.toInt() ?? 0;

        if (newMessages > 0) {
          settings.totalFreeAiMessages += newMessages;
          await _bodyRepo.saveUserSettings(settings);
          debugPrint(
            '[Referral] Synced $newMessages new free messages from referrals!',
          );
          return newMessages;
        }
      }
    } catch (e) {
      // Non-critical: silently fail if offline
      debugPrint('[Referral] syncReferralRewards error: $e');
    }
    return 0;
  }

  /// Reads the install referrer from the platform.
  ///
  /// - Android: Uses the Google Play Install Referrer API.
  ///   Requires `play_install_referrer` package.
  ///
  /// - iOS: Reads a stored referral code that was saved when the app was
  ///   opened via a Universal Link (handled in AppDelegate / SceneDelegate).
  ///   The iOS app should save the referral code to UserDefaults on the
  ///   first universal link open, readable here via MethodChannel.
  Future<String?> _readInstallReferrer() async {
    try {
      if (Platform.isAndroid) {
        // TODO: Add `play_install_referrer: ^2.0.1` to pubspec.yaml
        // Then replace the stub below with:
        //
        //   import 'package:play_install_referrer/play_install_referrer.dart';
        //   final referrer = await PlayInstallReferrer.installReferrer;
        //   // referrer.installReferrer contains something like:
        //   // "utm_source=muvio&utm_content=muvio_0_ref"
        //   return _parseReferralCode(referrer.installReferrer);
        //
        // Stub for development on Windows:
        return null;
      } else if (Platform.isIOS) {
        // TODO: In AppDelegate.swift, when a Universal Link opens the app,
        // save the referral code to UserDefaults:
        //
        //   UserDefaults.standard.set(referralCode, forKey: "pending_referral")
        //
        // Then read it here via MethodChannel:
        //
        //   const channel = MethodChannel('muvio/referral');
        //   return await channel.invokeMethod<String?>('getPendingReferral');
        //
        // Stub for development:
        return null;
      }
    } catch (e) {
      debugPrint('[Referral] _readInstallReferrer error: $e');
    }
    return null;
  }

  /// Generates the referral link for the current user to share.
  Future<String> generateReferralLink() async {
    final settings = await _bodyRepo.getUserSettings();
    final code = 'muvio_${settings.id}_ref';
    // For Android: deep link via Play Store referrer
    // For iOS: Universal Link
    return 'https://muvio.app/invite?ref=$code';
  }
}
