import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/category_items/view/category_items_view.dart';
import '../../features/home/view_model/home_view_model.dart';
import '../extensions/context_extension.dart';
import '../extensions/string_extension.dart';
import '../utils.dart';
import 'product_image_widget.dart';

class CategoryItemWidget extends ConsumerWidget {
  final String image;
  final String title;

  const CategoryItemWidget(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final products = ref
            .read(homeViewModelProvider.notifier)
            .filterProductsByCategory(category: title);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryItemsView(title: title, products: products),
          ),
        );
      },
      child: SizedBox(
        width: 108,
        child: Column(
          children: [
            ProductImageWidget(image: image),
            vGap(4),
            Text(
              title.capitalizeEachWord(),
              style: context.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
