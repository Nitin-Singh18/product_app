import 'package:flutter/material.dart';

import '../../../common/constants.dart';
import '../../../common/widgets/product_app_bar.dart';
import '../../../common/widgets/product_widget.dart';
import '../../../common/widgets/screen_content_wrapper_widget.dart';
import '../../../data/models/product.dart';
import '../../../theme/app_color.dart';

class ProductView extends StatelessWidget {
  final String title;
  final List<Product> products;

  const ProductView({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductAppBar(context: context, viewTitle: title),
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
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 108 / 146,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductWidget(product: product);
              },
            ),
          ),
        ),
      ),
    );
  }
}
