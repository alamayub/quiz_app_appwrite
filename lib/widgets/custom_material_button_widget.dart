import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text_widget.dart';
import 'package:quiz_app/widgets/loader.dart';

import '../config/constants.dart';

class CustomMaterialButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;
  final double radius;
  final double elevation;
  const CustomMaterialButtonWidget({
    Key? key,
    required this.title,
    required this.onPressed,
    this.loading = false,
    this.radius = 8,
    this.elevation = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 48,
      elevation: loading ? 0 : elevation,
      focusElevation: loading ? 0 : elevation,
      hoverElevation: loading ? 0 : elevation,
      disabledElevation: loading ? 0 : elevation,
      highlightElevation: loading ? 0 : elevation,
      disabledColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: double.infinity,
      onPressed: loading ? null : onPressed,
      color: primary,
      child: loading
          ? const Loader()
          : CustomTextWidget(
              title: title,
              color: Colors.white,
              isTitle: true,
            ),
    );
  }
}
