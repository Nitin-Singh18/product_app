import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../features/categories/view/categories_view.dart';
import '../../features/product/view/product_view.dart';
import '../../theme/app_color.dart';
import '../constants.dart';
import '../extensions/context_extension.dart';
import '../utils.dart';

class ItemsTileWidget extends StatelessWidget {
  final String title;
  final Widget items;

  // Tracks if the widget is being used to show categories or popular deals
  final bool isCategories;

  /// IF [isCategories] is true then [categories] should not be null
  final List<MapEntry<String, String>>? categories;

  /// IF [isCategories] is false then [popularDeals] should not be null
  final List<Product>? popularDeals;

  const ItemsTileWidget(
      {super.key,
      required this.title,
      required this.items,
      this.categories,
      required this.isCategories,
      this.popularDeals});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: verticalPaddingMedium,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        color: AppColor.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPaddingMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleLarge,
                ),
                TextButton(
                  child: Text(
                    "See all",
                    style: context.textTheme.titleMedium
                        ?.copyWith(color: AppColor.green),
                  ),
                  onPressed: () => navigateWithSlide(
                    context,
                    isCategories
                        ? CategoriesView(title: title, categories: categories!)
                        : ProductView(title: title, products: popularDeals!),
                  ),
                ),
              ],
            ),
          ),
          vGap(32),
          Padding(
              padding: const EdgeInsets.only(
                left: horizontalPaddingMedium,
              ),
              child: items)
        ],
      ),
    );
  }
}
