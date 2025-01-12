import 'package:flutter/material.dart';

class ProductTextTheme extends TextTheme {
  @override
  TextStyle? get displaySmall =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  @override
  TextStyle? get titleLarge =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);

  @override
  TextStyle? get titleMedium =>
      const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);

  @override
  TextStyle? get titleSmall =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  @override
  TextStyle? get labelMedium =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  @override
  TextStyle? get bodyLarge =>
      const TextStyle(fontSize: 14.3, fontWeight: FontWeight.w600);

  @override
  TextStyle? get bodyMedium => const TextStyle(fontSize: 12.5);
}
