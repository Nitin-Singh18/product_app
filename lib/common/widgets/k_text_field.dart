import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../constants.dart';
import '../extensions/context_extension.dart';
import '../utils.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? prefixIcon;

  const KTextField(
      {super.key,
      required this.label,
      this.prefixIcon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.white,
        prefixIcon: prefixIcon != null
            ? svgPicture(imagePath: prefixIcon!, color: AppColor.grey)
            : null,
        labelText: label,
        labelStyle:
            context.textTheme.titleMedium?.copyWith(color: AppColor.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
    );
  }
}
