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

void navigateWithSlide(BuildContext context, Widget destination) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

Widget heroAnimation(
        {required bool isAnimation,
        required Widget child,
        required String tag}) =>
    isAnimation ? Hero(tag: tag, child: child) : child;
