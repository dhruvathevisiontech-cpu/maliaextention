import 'package:get_storage/get_storage.dart';

class AuthSessionHelper {
  static final _storage = GetStorage();
  // static final _firestore = FirebaseFirestore.instance;
  static Future<void> saveSession({
    required String email,
    required String customerId,
    required String token,
    required String loginType,
    String? phone,
    String? idToken,
  }) async {

    final data = {
      "email": email,
      "customerId": customerId,
      "token": token,
      "idToken": idToken,
      "loginType": loginType,
      "phone": phone,
      "isLoggedIn": true,
      "createdAt": DateTime.now().toIso8601String(),
    };
    await _storage.write("session", data);
    await _storage.write("isLoggedIn", true);
    await _storage.write("userEmail", email);
    await _storage.write("userToken", token);
    await _storage.write("customerId", customerId);
    await _storage.write("idToken", idToken);
    await _storage.write("loginType", loginType);
    // await _firestore.collection("users").doc(email).set(
    //   data,
    //   SetOptions(merge: true),
    // );
  }
  static Map<String, dynamic>? getSession() {
    return _storage.read("session");
  }
  static Future<void> clearSession() async {
    await _storage.erase();
  }
}