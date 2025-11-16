import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/datum.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/course_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/material_tile.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/subject_card.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

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
          icon: const Icon(Icons.menu),
          color: AppColors.neutral900,
          onPressed: () {
            // Handle menu tap
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: AppColors.neutral900,
            onPressed: () {
              // Handle notification tap
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            color: AppColors.neutral900,
            onPressed: () {
              // Handle cart tap
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
                  color: AppColors.neutral300.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTypography.style14W400.copyWith(
                      color: AppColors.neutral500,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.neutral500,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.tune,
                        color: AppColors.neutral500,
                      ),
                      onPressed: () {
                        // Handle filter tap
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const Gap(24),
              // Subject Tutoring Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subject Tutoring',
                    style: AppTypography.style18W600.copyWith(
                      color: AppColors.neutral900,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle all subjects tap
                    },
                    child: Text(
                      'All Subjects >',
                      style: AppTypography.style14W400.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              SizedBox(
                height: 140,
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

