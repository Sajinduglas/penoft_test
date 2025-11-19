import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/dashboard/model/banner_model/banner_model.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/repo/dashboard_repository.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

class DashboardController extends GetxController {
  // Loading states
  final RxBool isLoadingSubjects = false.obs;
  final RxBool isLoadingBanner = false.obs;
  final RxBool isLoadingCourses = false.obs;
  final RxBool isLoadingMaterials = false.obs;

  // Data
  final RxList<SubjectListModel> subjects = <SubjectListModel>[].obs;
  final RxString bannerUrl = ''.obs;
  final RxList<CourseListModel> courses = <CourseListModel>[].obs;
  final RxList<MaterialListModel> materials = <MaterialListModel>[].obs;

  // Error states
  final RxnString subjectsError = RxnString(null);
  final RxnString bannerError = RxnString(null);
  final RxnString coursesError = RxnString(null);
  final RxnString materialsError = RxnString(null);

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadSubjects(),
      loadBanner(),
      loadCourses(),
      loadMaterials(),
    ]);
  }

  Future<void> loadSubjects() async {
    isLoadingSubjects.value = true;
    subjectsError.value = null;
    try {
      final data = await DashboardRepository.getSubjects();
      subjects.value = data;
    } on ApiException catch (e) {
      subjectsError.value = e.message;
    } catch (e) {
      subjectsError.value = e.toString();
    } finally {
      isLoadingSubjects.value = false;
    }
  }

  Future<void> loadBanner() async {
    isLoadingBanner.value = true;
    bannerError.value = null;
    try {
      final url = await DashboardRepository.getBanner();
      bannerUrl.value = url;
    } on ApiException catch (e) {
      bannerError.value = e.message;
    } catch (e) {
      bannerError.value = e.toString();
    } finally {
      isLoadingBanner.value = false;
    }
  }

  Future<void> loadCourses() async {
    isLoadingCourses.value = true;
    coursesError.value = null;
    try {
      final data = await DashboardRepository.getCourses();
      courses.value = data;
    } on ApiException catch (e) {
      coursesError.value = e.message;
    } catch (e) {
      coursesError.value = e.toString();
    } finally {
      isLoadingCourses.value = false;
    }
  }

  Future<void> loadMaterials() async {
    isLoadingMaterials.value = true;
    materialsError.value = null;
    try {
      final data = await DashboardRepository.getMaterials();
      materials.value = data;
    } on ApiException catch (e) {
      materialsError.value = e.message;
    } catch (e) {
      materialsError.value = e.toString();
    } finally {
      isLoadingMaterials.value = false;
    }
  }
}
