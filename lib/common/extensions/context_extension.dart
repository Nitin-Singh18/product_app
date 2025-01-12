import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  // Get textTheme on context
  TextTheme get textTheme => Theme.of(this).textTheme;
}
