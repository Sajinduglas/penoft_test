import 'package:flutter/material.dart';
import 'package:penoft_machine_test/modules/dashboard/model/subject_list_datum/datum.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class SubjectCardDatum {
  final SubjectListModel subject;
  final VoidCallback? onTap;

  SubjectCardDatum({
    required this.subject,
    this.onTap,
  });
}

class SubjectCard extends StatelessWidget {
  final SubjectCardDatum datum;

  const SubjectCard({super.key, required this.datum});

  Color _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return AppColors.primary;
    }
    try {
      String hex = colorString.replaceFirst('#', '');
      if (hex.length == 6) {
        return Color(int.parse('0xFF$hex'));
      } else if (hex.length == 8) {
        return Color(int.parse('0x$hex'));
      }
      return AppColors.primary;
    } catch (e) {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = _parseColor(datum.subject.mainColor);
    final gradientColor = _parseColor(datum.subject.gradientColor);

    return GestureDetector(
      onTap: datum.onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [mainColor, gradientColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (datum.subject.icon != null)
                Icon(
                  _getIconData(datum.subject.icon!),
                  size: 26,
                  color: AppColors.textWhite,
                ),
              const SizedBox(height: 8),
              Text(
                datum.subject.subject ?? '',
                style: AppTypography.style14W500.copyWith(
                  color: AppColors.textWhite,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'mathematics':
      case 'math':
        return Icons.calculate;
      case 'architecture':
        return Icons.architecture;
      case 'science':
        return Icons.science;
      case 'english':
        return Icons.menu_book;
      case 'history':
        return Icons.history;
      default:
        return Icons.school;
    }
  }
}
