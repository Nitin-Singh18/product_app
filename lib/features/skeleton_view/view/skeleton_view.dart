import 'package:flutter/material.dart';

import '../../../common/widgets/screen_content_wrapper_widget.dart';

class SkeletonView extends StatelessWidget {
  final String screenTitle;

  const SkeletonView({super.key, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenContentWrapperWidget(
        child: Center(
          child: Text(screenTitle),
        ),
      ),
    );
  }
}
