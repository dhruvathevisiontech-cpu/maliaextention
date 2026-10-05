class LoginResponse {
  final bool success;
  final bool isVerified;
  final String message;

  LoginResponse({
    required this.success,
    required this.isVerified,
    required this.message,
  });
}