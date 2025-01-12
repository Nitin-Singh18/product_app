import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/view_model/home_view_model.dart';
import '../../features/product/view/product_view.dart';
import '../extensions/context_extension.dart';
import '../extensions/string_extension.dart';
import '../utils.dart';
import 'product_image_widget.dart';

class CategoryItemWidget extends ConsumerWidget {
  final String image;
  final String title;
  final bool isHeroAnimation;

  const CategoryItemWidget({
    super.key,
    required this.image,
    required this.title,
    this.isHeroAnimation = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref
        .read(homeViewModelProvider.notifier)
        .filterProductsByCategory(category: title);
    return InkWell(
      onTap: () {
        navigateWithSlide(
            context, ProductView(title: title, products: products));
      },
      child: SizedBox(
        width: 108,
        child: Column(
          children: [
            heroAnimation(
              isAnimation: isHeroAnimation,
              tag: "product-${products.first.id}",
              child: ProductImageWidget(image: image),
            ),
            vGap(4),
            heroAnimation(
              isAnimation: isHeroAnimation,
              tag: title,
              child: Text(
                title.capitalizeEachWord(),
                style: context.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
