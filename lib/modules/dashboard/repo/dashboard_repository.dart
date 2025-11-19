import 'package:penoft_machine_test/config/api_config.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/dashboard/model/banner_model/banner_model.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/courses_list_datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/materials_list_datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/subject_list_datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/datum.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';
import 'package:penoft_machine_test/shared/network/api_helper.dart';
import 'package:penoft_machine_test/shared/network/api_response.dart';

class DashboardRepository {
  const DashboardRepository._();

  static Future<Map<String, String>> _getAuthHeaders() async {
    final token = await LocalDb.getSavedToken();
    if (token == null || token.isEmpty) {
      throw const ApiException('No authentication token found');
    }
    return {'Authorization': 'Bearer $token'};
  }

  static Future<List<SubjectListModel>> getSubjects() async {
    final headers = await _getAuthHeaders();
    final ApiResponse<dynamic> response = await ApiHelper.get(
      endPoint: ApiEndpoint.subjects,
      headers: headers,
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

    final data = response.data as Map<String, dynamic>;
    final subjectListDatum = SubjectListDatum.fromJson(data);
    return subjectListDatum.data ?? [];
  }

  static Future<String> getBanner() async {
    final headers = await _getAuthHeaders();
    final ApiResponse<dynamic> response = await ApiHelper.get(
      endPoint: ApiEndpoint.banner,
      headers: headers,
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

    final data = response.data as Map<String, dynamic>;
    final bannerModel = BannerModel.fromJson(data);
    return bannerModel.data ?? '';
  }

  static Future<List<CourseListModel>> getCourses() async {
    final headers = await _getAuthHeaders();
    final ApiResponse<dynamic> response = await ApiHelper.get(
      endPoint: ApiEndpoint.courses,
      headers: headers,
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

    final data = response.data as Map<String, dynamic>;
    final coursesListDatum = CoursesListDatum.fromJson(data);
    return coursesListDatum.data ?? [];
  }

  static Future<List<MaterialListModel>> getMaterials() async {
    final headers = await _getAuthHeaders();
    final ApiResponse<dynamic> response = await ApiHelper.get(
      endPoint: ApiEndpoint.materials,
      headers: headers,
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

    final data = response.data as Map<String, dynamic>;
    final materialsListDatum = MaterialsListDatum.fromJson(data);
    return materialsListDatum.data ?? [];
  }
}
