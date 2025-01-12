import 'package:flutter/material.dart';

import 'app_color.dart';
import 'product_text_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColor.green,
    ),
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: ProductTextTheme(),
    scaffoldBackgroundColor: AppColor.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.green,
      elevation: 0,
      scrolledUnderElevation: 0.0,
    ),
  );
}
