import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:penoft_machine_test/modules/dashboard/model/courses_list_datum/datum.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class CourseTileDatum {
  final CourseListModel course;
  final VoidCallback? onTap;

  CourseTileDatum({
    required this.course,
    this.onTap,
  });
}

class CourseTile extends StatelessWidget {
  final CourseTileDatum datum;

  const CourseTile({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: datum.onTap,
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.backgroundWhite,
          // border: Border.all(
          //   color: AppColors.borderLight,
          //   width: 1,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  datum.course.image ?? '',
                  width: 120,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 120,
                      height: double.infinity,
                      color: AppColors.neutral300,
                      child: const Icon(Icons.image, size: 40),
                    );
                  },
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      datum.course.title ?? '',
                      style: AppTypography.style14W500.copyWith(
                        color: AppColors.neutral900,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                    Text(
                      '${datum.course.author ?? ''} - ${datum.course.duration ?? ''}',
                      style: AppTypography.style12W400.copyWith(
                        color: AppColors.neutral600,
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Text(
                          '\$${datum.course.price ?? '0.00'}',
                          style: AppTypography.style14W500.copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                        if (datum.course.originalPrice != null &&
                            datum.course.originalPrice!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '\$${datum.course.originalPrice}',
                              style: AppTypography.style12W400.copyWith(
                                color: AppColors.neutral500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Gap(6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const Gap(4),
                        Text(
                          '${datum.course.rating ?? 0.0} (${datum.course.reviews ?? 0})',
                          style: AppTypography.style12W400.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      ],
                    ),
                    if (datum.course.tag != null &&
                        datum.course.tag!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            datum.course.tag!,
                            style: AppTypography.style12W400.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
