import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../constants.dart';
import '../extensions/context_extension.dart';
import '../extensions/string_extension.dart';
import '../utils.dart';

class ProductAppBar extends AppBar {
  final BuildContext context;
  final String viewTitle;

  ProductAppBar({required this.context, required this.viewTitle, super.key});

  @override
  Widget? get title => Hero(
        tag: viewTitle,
        child: Text(
          viewTitle.capitalizeEachWord(),
          style: context.textTheme.titleLarge?.copyWith(color: AppColor.white),
        ),
      );

  @override
  bool? get centerTitle => true;

  @override
  Widget? get leading => IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.zero,
        icon: svgPicture(
          imagePath: AssetPath.backArrowIcon,
          height: 20,
          color: AppColor.white,
        ),
      );
}
