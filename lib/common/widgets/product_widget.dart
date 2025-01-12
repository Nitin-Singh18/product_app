import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/product.dart';
import '../../features/cart/view_model/cart_view_model.dart';
import '../../theme/app_color.dart';
import '../constants.dart';
import '../extensions/context_extension.dart';
import '../utils.dart';
import 'product_image_widget.dart';

class ProductWidget extends ConsumerWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // trigger rebuild
    ref.watch(cartViewModelProvider);
    final cartNotifier = ref.read(cartViewModelProvider.notifier);

    final productQuantity = ref
        .watch(cartViewModelProvider.notifier)
        .getProductQuantity(product.id);

    return Column(
      children: [
        Hero(
          tag: "product-${product.id}-${product.title}",
          child: ProductImageWidget(
            image: product.image,
            width: double.infinity,
            height: 140,
          ),
        ),
        vGap(2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium,
                  ),
                  Text(
                    "\$${product.price.toString()}",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColor.green,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusSmall),
                    ),
                    color: AppColor.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (productQuantity > 0) ...[
                        InkWell(
                          onTap: () {
                            cartNotifier.removeProduct(product);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          productQuantity.toString(),
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColor.white),
                        ),
                      ],
                      InkWell(
                        onTap: () {
                          cartNotifier.addProduct(product);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
