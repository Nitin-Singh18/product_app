import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions/context_extension.dart';
import '../utils.dart';
import 'product_image_widget.dart';
import '../../data/models/product.dart';
import '../../theme/app_color.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImageWidget(
          image: product.image,
          width: double.infinity,
          height: 140,
        ),
        vGap(2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: [
                      if (true) ...[
                        InkWell(
                          onTap: () {
                            print("Remove");
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          "01",
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: AppColor.white),
                        ),
                      ],
                      InkWell(
                        onTap: () {
                          print("Add");
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
