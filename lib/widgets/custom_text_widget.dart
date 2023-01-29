import 'package:flutter/material.dart';

import '../config/constants.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final int? maxLines;
  final bool isTitle;
  final Color? color;
  final double? fontSize;
  final bool center;
  final FontWeight? fontWeight;
  const CustomTextWidget({
    Key? key,
    required this.title,
    this.maxLines,
    this.isTitle = false,
    this.color,
    this.fontSize,
    this.center = false,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: center == true ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        letterSpacing: .5,
        fontSize: isTitle == true ? 16 : (fontSize ?? 12),
        color: color ?? textColor,
        fontWeight: fontWeight ?? (isTitle == true ? FontWeight.w500 : FontWeight.normal),
      ),
    );
  }
}