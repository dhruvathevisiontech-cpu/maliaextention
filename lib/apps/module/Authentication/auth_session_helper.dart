import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class AuthSessionHelper {
  static final _storage = GetStorage();
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static const String _accessTokenKey = 'malia_access_token';
  static const String _idTokenKey = 'malia_id_token';
  static const String _refreshTokenKey = 'malia_refresh_token';
  static const String _tokenExpiryKey = 'malia_token_expiry';
  static Future<void> saveSession({
    required String email,
    required String customerId,
    required String token,
    required String loginType,
    String? phone,
    String? idToken,
    String? refreshToken,
    DateTime? accessTokenExpiresAt,
  }) async {
    if (token.isEmpty) {
      throw Exception('Access token is empty.');
    }
    await _secureStorage.write(
      key: _accessTokenKey,
      value: token,
    );
    if (idToken != null && idToken.isNotEmpty) {
      await _secureStorage.write(
        key: _idTokenKey,
        value: idToken,
      );
    } else {
      await _secureStorage.delete(key: _idTokenKey);
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _secureStorage.write(
        key: _refreshTokenKey,
        value: refreshToken,
      );
    } else {
      await _secureStorage.delete(key: _refreshTokenKey);
    }
    if (accessTokenExpiresAt != null) {
      await _secureStorage.write(
        key: _tokenExpiryKey,
        value: accessTokenExpiresAt.toIso8601String(),
      );
    } else {
      await _secureStorage.delete(key: _tokenExpiryKey);
    }
    final data = {
      'email': email,
      'customerId': customerId,
      'loginType': loginType,
      'phone': phone,
      'isLoggedIn': true,
      'createdAt': DateTime.now().toIso8601String(),
    };
    await _storage.write('session', data);
    await _storage.write('isLoggedIn', true);
    await _storage.write('userEmail', email);
    await _storage.write('customerId', customerId);
    await _storage.write('loginType', loginType);
  }

  static bool isLoggedIn() {
    return _storage.read('isLoggedIn') == true;
  }

  static Future<String?> getAccessToken() async {
    return _secureStorage.read(key: _accessTokenKey);
  }

  static Future<String?> getIdToken() async {
    return _secureStorage.read(key: _idTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<DateTime?> getAccessTokenExpiry() async {
    final value = await _secureStorage.read(key: _tokenExpiryKey);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  static Future<void> logout() async {
    await _storage.write('isLoggedIn', false);
    final session = _storage.read('session');
    if (session is Map) {
      final updatedSession = Map<String, dynamic>.from(session);
      updatedSession['isLoggedIn'] = false;
      await _storage.write('session', updatedSession);
    }
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _idTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _tokenExpiryKey);
  }

  static Map<String, dynamic>? getSession() {
    final session = _storage.read('session');
    if (session is Map) {
      return Map<String, dynamic>.from(session);
    }
    return null;
  }
  static Future<void> clearSession() async {
    await _storage.remove('session');
    await _storage.remove('isLoggedIn');
    await _storage.remove('userEmail');
    await _storage.remove('customerId');
    await _storage.remove('loginType');
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _idTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
    await _secureStorage.delete(key: _tokenExpiryKey);
  }
}