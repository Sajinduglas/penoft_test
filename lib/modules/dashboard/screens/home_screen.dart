import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/circle_icon.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/course_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/material_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/subject_card.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Mock data - will be replaced with API data later
  List<SubjectListModel> get _mockSubjects => [
        SubjectListModel(
          subject: 'Mathematics',
          icon: 'mathematics',
          mainColor: '#FF6B35',
          gradientColor: '#F7931E',
        ),
        SubjectListModel(
          subject: 'Architecture',
          icon: 'architecture',
          mainColor: '#4A90E2',
          gradientColor: '#50C9C3',
        ),
        SubjectListModel(
          subject: 'Science',
          icon: 'science',
          mainColor: '#9B59B6',
          gradientColor: '#8E44AD',
        ),
        SubjectListModel(
          subject: 'English',
          icon: 'english',
          mainColor: '#E74C3C',
          gradientColor: '#C0392B',
        ),
      ];

  List<CourseListModel> get _mockCourses => [
        CourseListModel(
          title: 'JavaScript for Modern Web Development',
          author: 'Robert Fox',
          duration: '3 hr',
          price: '10.99',
          originalPrice: '32',
          rating: 4.5,
          reviews: 2980,
          tag: 'Top Author',
          image: 'https://via.placeholder.com/120x80',
        ),
        CourseListModel(
          title: 'Python Programming for Data Analysis',
          author: 'Eleanor Pena',
          duration: '3 hr',
          price: '10.99',
          originalPrice: '32',
          rating: 4.5,
          reviews: 2980,
          tag: 'Top Author',
          image: 'https://via.placeholder.com/120x80',
        ),
      ];

  List<MaterialListModel> get _mockMaterials => [
        MaterialListModel(
          title: 'Premium Gel Pen - Pack of 10',
          brand: 'ClassMate',
          price: '4.99',
          originalPrice: '12',
          rating: 4.5,
          reviews: 2590,
          tag: 'Top Choice',
          image: 'https://via.placeholder.com/100x100',
        ),
        MaterialListModel(
          title: 'A5 Spiral Notebook - 200 Pages',
          brand: 'ClassMate',
          price: '10.99',
          originalPrice: '32',
          rating: 4.9,
          reviews: 8980,
          tag: 'Top Rated',
          image: 'https://via.placeholder.com/100x100',
        ),
        MaterialListModel(
          title: 'Ergonomic Adjustable Laptop Stand',
          brand: 'TechMate',
          price: '10.99',
          originalPrice: '32',
          rating: 4.5,
          reviews: 2980,
          tag: 'Students Pick',
          image: 'https://via.placeholder.com/100x100',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child:
                const Icon(Icons.logout, size: 14, color: AppColors.neutral900),
            onPressed: () {
              appRouteState.logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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

                    // Make sure prefix has a fixed size so it doesn't shrink
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: SizedBox(
                        width: 20, // desired icon width
                        height: 20, // desired icon height
                        child: Assets.svg.search
                            .icon(context, color: AppColors.neutral500),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40, // total tappable area reserved
                      minHeight: 40,
                    ),

                    // Suffix (filter) — remove IconButton default padding and give constraints
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
                          width: .5,
                          color: AppColors.neutral300), // or keep default
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
              .icon(context,color: AppColors.primary,)
              .square(10)
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _mockSubjects.length,
                  itemBuilder: (context, index) {
                    return SubjectCard(
                      datum: SubjectCardDatum(
                        subject: _mockSubjects[index],
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9B59B6),
                      Color(0xFFE91E63),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Get Lifetime ',
                                  style: AppTypography.style18W600.copyWith(
                                    color: AppColors.textWhite,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Deal',
                                  style: AppTypography.style18W600.copyWith(
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'Access to all on-demand courses',
                            style: AppTypography.style14W400.copyWith(
                              color: AppColors.textWhite,
                            ),
                          ),
                          const Gap(16),
                          ElevatedButton(
                            onPressed: () {
                              // Handle redeem tap
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C3AED),
                              foregroundColor: AppColors.textWhite,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Redeem Now',
                              style: AppTypography.style14W500.copyWith(
                                color: AppColors.textWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(24),
              // All Courses Section
              Text(
                'All Courses',
                style: AppTypography.style18W600.copyWith(
                  color: AppColors.neutral900,
                ),
              ),
              const Gap(16),
              ..._mockCourses.map(
                (course) => CourseTile(
                  datum: CourseTileDatum(
                    course: course,
                    onTap: () {
                      // Handle course tap
                    },
                  ),
                ),
              ),
              const Gap(24),
              // Buy Materials Section
              Text(
                'Buy Materials',
                style: AppTypography.style18W600.copyWith(
                  color: AppColors.neutral900,
                ),
              ),
              const Gap(16),
              ..._mockMaterials.map(
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
    );
  }
}
