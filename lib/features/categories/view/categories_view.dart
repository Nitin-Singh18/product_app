import 'package:flutter/material.dart';

import '../../../common/constants.dart';

import '../../../common/widgets/category_item_widget.dart';
import '../../../common/widgets/product_app_bar.dart';
import '../../../common/widgets/screen_content_wrapper_widget.dart';
import '../../../theme/app_color.dart';

class CategoriesView extends StatelessWidget {
  final String title;
  final List<MapEntry<String, String>> categories;

  const CategoriesView(
      {super.key, required this.categories, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(context: context, viewTitle: "Categories"),
      body: SafeArea(
        child: ScreenContentWrapperWidget(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: horizontalPaddingMedium,
              horizontal: horizontalPaddingMedium,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadiusMedium),
                color: AppColor.white),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 108 / 156,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryItemWidget(
                  image: category.value,
                  title: category.key,
                  isHeroAnimation: true,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
