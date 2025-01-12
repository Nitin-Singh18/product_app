import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../constants.dart';

class ProductImageWidget extends StatelessWidget {
  final String image;

  final double width;
  final double height;

  const ProductImageWidget(
      {super.key, required this.image, this.width = 108, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          borderRadiusSmall,
        ),
        color: AppColor.honeyDew,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadiusSmall,
        ),
        child: Image.network(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
