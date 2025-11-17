import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:penoft_machine_test/config/api_config.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';
import 'package:penoft_machine_test/shared/network/api_response.dart';

class ApiHelper {
  ApiHelper._();

  static const Duration _defaultTimeout = Duration(seconds: 30);

  static Map<String, String> _headers(
    Map<String, String>? custom, {
    bool isMultipart = false,
  }) {
    final headers = <String, String>{
      'Accept': 'application/json',
      if (!isMultipart) 'Content-Type': 'application/json',
    };
    if (custom != null) {
      headers.addAll(custom);
    }
    return headers;
  }

  static Future<ApiResponse<dynamic>> get({
    required String endPoint,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = ApiConfig.uri(endPoint);
      final response = await http
          .get(uri, headers: _headers(headers))
          .timeout(_defaultTimeout);
      return _parseResponse(response);
    } on SocketException {
      throw const ApiException('No internet connection');
    } on TimeoutException {
      throw const ApiException('Request timed out');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  static Future<ApiResponse<dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = ApiConfig.uri(endPoint);
      final response = await http
          .post(
            uri,
            headers: _headers(headers),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_defaultTimeout);
      return _parseResponse(response);
    } on SocketException {
      throw const ApiException('No internet connection');
    } on TimeoutException {
      throw const ApiException('Request timed out');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  static Future<ApiResponse<dynamic>> postMultipart({
    required String endPoint,
    Map<String, dynamic>? fields,
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final uri = ApiConfig.uri(endPoint);
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(_headers(headers, isMultipart: true));
      if (fields != null) {
        fields.forEach((key, value) {
          if (value != null) {
            request.fields[key] = value.toString();
          }
        });
      }
      if (files != null && files.isNotEmpty) {
        request.files.addAll(files);
      }
      final streamedResponse = await request.send().timeout(_defaultTimeout);
      final response = await http.Response.fromStream(streamedResponse);
      return _parseResponse(response);
    } on SocketException {
      throw const ApiException('No internet connection');
    } on TimeoutException {
      throw const ApiException('Request timed out');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  static ApiResponse<dynamic> _parseResponse(http.Response response) {
    dynamic decoded;
    if (response.body.isNotEmpty) {
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = response.body;
      }
    }
    final message =
        _extractMessage(decoded) ?? response.reasonPhrase ?? 'Unknown error';
    return ApiResponse(
      statusCode: response.statusCode,
      message: message,
      data: decoded,
    );
  }

  static String? _extractMessage(dynamic decoded) {
    if (decoded is Map<String, dynamic>) {
      final msg = decoded['message'];
      if (msg is String && msg.trim().isNotEmpty) {
        return msg;
      }
      final error = decoded['error'];
      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
    }
    return null;
  }
}
