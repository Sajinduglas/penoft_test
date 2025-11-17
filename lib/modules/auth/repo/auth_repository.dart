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

  static Future<String> uploadProfilePicture({
    required String token,
    required XFile image,
  }) async {
    final file = await http.MultipartFile.fromPath('picture', image.path);

    final ApiResponse<dynamic> response = await ApiHelper.postMultipart(
      endPoint: ApiEndpoint.addProfilePicture,
      headers: {
        'Authorization': 'Bearer $token',
      },
      files: [file],
    );

    if (!response.isSuccess) {
      throw ApiException(
        response.message,
        statusCode: response.statusCode,
      );
    }

    return response.message;
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
