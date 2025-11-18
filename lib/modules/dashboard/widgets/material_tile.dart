import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/dashboard/controller/cart_controller.dart';
import 'package:penoft_machine_test/modules/dashboard/model/materials_list_datum/datum.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class MaterialTileDatum {
  final MaterialListModel material;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  MaterialTileDatum({
    required this.material,
    this.onTap,
    this.onAddTap,
  });
}

class MaterialTile extends StatelessWidget {
  final MaterialTileDatum datum;

  const MaterialTile({super.key, required this.datum});

  Color _getTagColor(String? tag) {
    if (tag == null) return AppColors.primary;
    switch (tag.toLowerCase()) {
      case 'top choice':
        return AppColors.primary;
      case 'top rated':
        return AppColors.primary;
      case 'students pick':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: datum.onTap,
      
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(bottom: 16),
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
                  datum.material.image ?? '',
                  width: 100,
                 height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                datum.material.title ?? '',
                                style: AppTypography.style14W500.copyWith(
                                  color: AppColors.neutral900,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(4),
                              Text(
                                'by ${datum.material.brand ?? ''}',
                                style: AppTypography.style12W400.copyWith(
                                  color: AppColors.neutral600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          final quantity = cartController.getQuantity(datum.material);
                          final isInCart = quantity > 0;

                          if (isInCart) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cartController.removeFromCart(datum.material);
                                    datum.onAddTap?.call();
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 14,
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                ),
                                const Gap(8),
                                Text(
                                  '$quantity',
                                  style: AppTypography.style14W500.copyWith(
                                    color: AppColors.neutral900,
                                  ),
                                ),
                                const Gap(8),
                                InkWell(
                                  onTap: () {
                                    cartController.addToCart(datum.material);
                                    datum.onAddTap?.call();
                                  },
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 14,
                                      color: AppColors.textWhite,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                cartController.addToCart(datum.material);
                                datum.onAddTap?.call();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Add',
                                  style: AppTypography.style12W400.copyWith(
                                    color: AppColors.textWhite,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Text(
                          '\$${datum.material.price ?? '0.00'}',
                          style: AppTypography.style14W500.copyWith(
                            color: AppColors.neutral900,
                          ),
                        ),
                        if (datum.material.originalPrice != null &&
                            datum.material.originalPrice!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              '\$${datum.material.originalPrice}',
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
                          '${datum.material.rating ?? 0.0} (${datum.material.reviews ?? 0})',
                          style: AppTypography.style12W400.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                      ],
                    ),
                    if (datum.material.tag != null &&
                        datum.material.tag!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getTagColor(datum.material.tag)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            datum.material.tag!,
                            style: AppTypography.style12W400.copyWith(
                              color: _getTagColor(datum.material.tag),
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
