import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/app_color.dart';

SizedBox hGap(double width) {
  return SizedBox(width: width);
}

SizedBox vGap(double height) {
  return SizedBox(height: height);
}

SvgPicture svgPicture({
  required String imagePath,
  double height = 24,
  double width = 24,
  Color color = AppColor.white,
}) {
  return SvgPicture.asset(
    imagePath,
    height: height,
    width: width,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
