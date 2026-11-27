import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:maliaextention/apps/module/Authentication/auth_session_helper.dart';

class GoogleAuthController extends GetxController {
  final RxBool isLoading = false.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<void>? _initialization;
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

    final random = Random.secure();

    return List.generate(
      length,
          (_) => charset[random.nextInt(charset.length)],
    ).join();
  }
  Future<void> _initializeGoogleSignIn() async {
    _initialization ??= _googleSignIn.initialize();
    await _initialization;
  }
  Future<void> signInWithApple() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      // Generate secure nonce.
      final rawNonce = _generateNonce();

      // Hash nonce for Apple.
      final nonce = sha256.convert(
        utf8.encode(rawNonce),
      ).toString();

      // Open Apple's native sign-in screen.
      final appleCredential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final appleIdToken = appleCredential.identityToken;

      if (appleIdToken == null || appleIdToken.isEmpty) {
        throw Exception('Apple identity token was not received.');
      }

      // Create Firebase Apple credential.
      final OAuthCredential credential =
      OAuthProvider('apple.com').credential(
        idToken: appleIdToken,
        rawNonce: rawNonce,
      );

      // Sign in with Firebase.
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase user was not returned.');
      }

      // Save Apple name if Firebase does not already have one.
      final fullName = [
        appleCredential.givenName,
        appleCredential.familyName,
      ].where((name) => name != null && name.isNotEmpty).join(' ');

      if (fullName.isNotEmpty &&
          (firebaseUser.displayName == null ||
              firebaseUser.displayName!.isEmpty)) {
        await firebaseUser.updateDisplayName(fullName);
      }

      // Get Firebase ID token.
      final firebaseIdToken = await firebaseUser.getIdToken();

      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        throw Exception('Firebase ID token was not received.');
      }

      // Save Firebase session separately from Shopify.
      await AuthSessionHelper.saveGoogleSession(
        email: firebaseUser.email ?? appleCredential.email ?? '',
        firebaseUid: firebaseUser.uid,
        firebaseIdToken: firebaseIdToken,
        phone: firebaseUser.phoneNumber,
      );

      Get.snackbar(
        'Success',
        'Apple sign-in successful.',
        snackPosition: SnackPosition.BOTTOM,
      );

      // We'll connect your existing bottom navigation route here.

    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return;
      }

      Get.snackbar(
        'Apple Sign-In',
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );

    } on FirebaseAuthException catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        'Authentication Error',
        e.message ?? e.code,
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {
      isLoading.value = false;
    }
  }
  Future<void> signInWithGoogle() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;

      // Initialize Google Sign-In once.
      await _initializeGoogleSignIn();

      // Open Google account selection.
      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      // Get Google authentication token.
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? googleIdToken = googleAuth.idToken;

      if (googleIdToken == null || googleIdToken.isEmpty) {
        throw Exception('Google ID token was not received.');
      }

      // Create Firebase credential.
      final OAuthCredential credential =
      GoogleAuthProvider.credential(
        idToken: googleIdToken,
      );

      // Authenticate with Firebase.
      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        throw Exception('Firebase user was not returned.');
      }

      // Get Firebase ID token, not the Google ID token.
      final String? firebaseIdToken =
      await firebaseUser.getIdToken();

      if (firebaseIdToken == null || firebaseIdToken.isEmpty) {
        throw Exception('Firebase ID token was not received.');
      }

      // Save Firebase session separately from Shopify tokens.
      await AuthSessionHelper.saveGoogleSession(
        email: firebaseUser.email ?? googleUser.email,
        firebaseUid: firebaseUser.uid,
        firebaseIdToken: firebaseIdToken,
        phone: firebaseUser.phoneNumber,
      );

      Get.snackbar(
        'Success',
        'Google sign-in successful.',
        snackPosition: SnackPosition.BOTTOM,
      );

      // We'll connect your existing bottom navigation route here.
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User cancelled account selection.
        return;
      }

      Get.snackbar(
        'Google Sign-In',
        e.description ?? e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Authentication Error',
        e.message ?? e.code,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
