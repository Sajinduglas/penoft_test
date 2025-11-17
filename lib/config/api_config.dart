class ApiConfig {
  ApiConfig._();

  /// Base URL for all API calls.
  static const String baseUrl = 'https://machinetest.flutter.penoft.com/api';

  /// Helper to build a complete [Uri] from a relative [endpoint].
  static Uri uri(String endpoint) {
    final normalized = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    return Uri.parse('$baseUrl$normalized');
  }
}

class ApiEndpoint {
  ApiEndpoint._();

  static const String sendOtp = '/user/send-otp';
  static const String verifyOtp = '/user/verify-otp';
  static const String addFullName = '/user/add-fullname';
  static const String completeProfile =
      '/user/complete-profile'; // TODO: confirm with backend
}
