import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../constants.dart';

class ScreenContentWrapperWidget extends StatelessWidget {
  final Widget child;

  const ScreenContentWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingSmall,
        vertical: horizontalPaddingSmall,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusLarge),
          topRight: Radius.circular(borderRadiusLarge),
        ),
        color: AppColor.ghostWhite,
      ),
      child: child,
    );
  }
}
