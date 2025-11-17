import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/dashboard/controller/dashboard_controller.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/circle_icon.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/course_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/material_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/subject_card.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DashboardController controller;
  final String tag = tagGenerator();

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController(), tag: tag);
  }

  @override
  void dispose() {
    Get.delete<DashboardController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          leading: IconButton(
            icon: Assets.svg.drawer
                .icon(context, color: AppColors.neutral900)
                .square(16),
            color: AppColors.neutral900,
            onPressed: () {
              // Handle menu tap
            },
          ),
          actions: [
            CircleIconButton(
              size: 40,
              borderColor: AppColors.neutral300,
              backgroundColor: AppColors.backgroundWhite,
              child: Assets.svg.bell
                  .icon(context, color: AppColors.neutral900)
                  .square(14),
              onPressed: () {
                // Handle notification tap
              },
            ),
            const SizedBox(width: 8),
            CircleIconButton(
              size: 40,
              borderColor: AppColors.neutral300,
              backgroundColor: AppColors.backgroundWhite,
              child: Assets.svg.cart
                  .icon(context, color: AppColors.neutral900)
                  .square(14),
              onPressed: () {
                // Handle cart tap
              },
            ),
            const SizedBox(width: 8),
            CircleIconButton(
              size: 40,
              borderColor: AppColors.neutral300,
              backgroundColor: AppColors.backgroundWhite,
              child: const Icon(Icons.logout,
                  size: 14, color: AppColors.neutral900),
              onPressed: () {
                appRouteState.logout();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.loadAllData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(16),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppTypography.style14W400.copyWith(
                          color: AppColors.neutral500,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Assets.svg.search
                                .icon(context, color: AppColors.neutral500),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 40, minHeight: 40),
                          icon: Assets.svg.adjustmentsHorizontal
                              .icon(context, color: AppColors.neutral500)
                              .square(17),
                          onPressed: () {
                            // Handle filter tap
                          },
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              width: .5, color: AppColors.neutral300),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  // Subject Tutoring Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subject Tutoring',
                        style: AppTypography.style16W600.copyWith(
                          color: AppColors.neutral900,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle all subjects tap
                        },
                        child: Row(
                          children: [
                            Text(
                              'All Subjects ',
                              style: AppTypography.style14W500.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            Assets.svg.forwardArrow
                                .icon(context, color: AppColors.primary)
                                .square(10)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  // Subjects List
                  if (controller.isLoadingSubjects.value)
                    const SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (controller.subjectsError.value != null)
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Failed to load subjects',
                              style: AppTypography.style14W400.copyWith(
                                color: AppColors.neutral600,
                              ),
                            ),
                            TextButton(
                              onPressed: () => controller.loadSubjects(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.subjects.length,
                        itemBuilder: (context, index) {
                          return SubjectCard(
                            datum: SubjectCardDatum(
                              subject: controller.subjects[index],
                              onTap: () {
                                // Handle subject tap
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  const Gap(24),
                  // Promotional Banner
                  if (controller.isLoadingBanner.value)
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else if (controller.bannerError.value != null)
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Failed to load banner',
                            style: AppTypography.style14W400.copyWith(
                              color: AppColors.neutral600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => controller.loadBanner(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else if (controller.bannerUrl.value.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        controller.bannerUrl.value,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: AppColors.neutral300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.image,
                              size: 60,
                              color: AppColors.neutral500,
                            ),
                          );
                        },
                      ),
                    ),
                  const Gap(20),
                  // All Courses Section
                  Text(
                    'All Courses',
                    style: AppTypography.style16W600.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  const Gap(8),
                  if (controller.isLoadingCourses.value)
                    const Center(child: CircularProgressIndicator())
                  else if (controller.coursesError.value != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Failed to load courses',
                            style: AppTypography.style14W400.copyWith(
                              color: AppColors.neutral600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => controller.loadCourses(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else
                    ...controller.courses.map(
                      (course) => CourseTile(
                        datum: CourseTileDatum(
                          course: course,
                          onTap: () {
                            // Handle course tap
                          },
                        ),
                      ),
                    ),
                  const Gap(20),
                  // Buy Materials Section
                  Text(
                    'Buy Materials',
                    style: AppTypography.style18W600.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  const Gap(12),
                  if (controller.isLoadingMaterials.value)
                    const Center(child: CircularProgressIndicator())
                  else if (controller.materialsError.value != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Failed to load materials',
                            style: AppTypography.style14W400.copyWith(
                              color: AppColors.neutral600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => controller.loadMaterials(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  else
                    ...controller.materials.map(
                      (material) => MaterialTile(
                        datum: MaterialTileDatum(
                          material: material,
                          onTap: () {
                            // Handle material tap
                          },
                          onAddTap: () {
                            // Handle add to cart
                          },
                        ),
                      ),
                    ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
