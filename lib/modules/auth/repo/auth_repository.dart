import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:penoft_machine_test/config/api_config.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';
import 'package:penoft_machine_test/shared/network/api_helper.dart';
import 'package:penoft_machine_test/shared/network/api_response.dart';

class AuthRepository {
  const AuthRepository._();

  static Future<String> requestOtp(String email) async {
    final ApiResponse<dynamic> response = await ApiHelper.post(
      endPoint: ApiEndpoint.sendOtp,
      body: {'email': email},
    );
    if (!response.isSuccess) {
      throw ApiException(
        response.message,
        statusCode: response.statusCode,
      );
    }
    return response.message;
  }

  static Future<VerifyOtpResult> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final ApiResponse<dynamic> response = await ApiHelper.post(
      endPoint: ApiEndpoint.verifyOtp,
      body: {
        'email': email,
        'otp': otp,
      },
    );

    if (!response.isSuccess) {
      throw ApiException(
        response.message,
        statusCode: response.statusCode,
      );
    }

    if (response.data is! Map<String, dynamic>) {
      throw const ApiException('Invalid response from server');
    }

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    final token = data['token']?.toString();
    final userId = data['userId']?.toString();

    if (token == null || token.isEmpty) {
      throw const ApiException('Token missing in response');
    }

    if (userId == null || userId.isEmpty) {
      throw const ApiException('User id missing in response');
    }

    return VerifyOtpResult(
      token: token,
      user: User(
        id: userId,
        email: email,
      ),
    );
  }

  static Future<String> addFullName({
    required String token,
    required String fullName,
  }) async {
    final ApiResponse<dynamic> response = await ApiHelper.post(
      endPoint: ApiEndpoint.addFullName,
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'fullname': fullName,
      },
    );

    if (!response.isSuccess) {
      throw ApiException(
        response.message,
        statusCode: response.statusCode,
      );
    }

    return response.message;
  }

  /// Placeholder for profile completion API.
  /// Once backend shares the endpoint + required fields we can update the call.
  static Future<User> completeProfile({
    required String token,
    required String fullname,
    required String email,
    XFile? profileImage,
  }) async {
    final fields = {
      'fullname': fullname,
      'email': email,
    };

    final files = <http.MultipartFile>[];
    if (profileImage != null) {
      files.add(
        await http.MultipartFile.fromPath(
          'profile_image',
          profileImage.path,
        ),
      );
    }

    final ApiResponse<dynamic> response = await ApiHelper.postMultipart(
      endPoint: ApiEndpoint.completeProfile,
      headers: {
        'Authorization': 'Bearer $token',
      },
      fields: fields,
      files: files,
    );

    if (!response.isSuccess) {
      throw ApiException(
        response.message,
        statusCode: response.statusCode,
      );
    }

    final data = response.data;
    if (data is Map<String, dynamic>) {
      final userMap = data['user'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(
              data['user'] as Map<String, dynamic>,
            )
          : data;
      return User(
        id: userMap['id']?.toString(),
        name: (userMap['name'] ?? userMap['fullname'] ?? fullname)?.toString(),
        email: (userMap['email'] ?? email)?.toString(),
      );
    }

    return User(
      name: fullname,
      email: email,
    );
  }
}

class VerifyOtpResult {
  VerifyOtpResult({
    required this.token,
    required this.user,
  });

  final String token;
  final User user;
}
