import 'package:maliaextention/apps/model/loginmodel.dart';

class AuthRepository {

  Future<LoginResponse> login(String email) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@gmail.com") {
      return LoginResponse(
        success: true,
        isVerified: true,
        message: "OTP sent successfully",
      );
    }

    return LoginResponse(
      success: false,
      isVerified: false,
      message: "Email not registered",
    );
  }

}