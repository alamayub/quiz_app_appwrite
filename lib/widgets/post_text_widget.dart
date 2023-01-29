import 'package:flutter/material.dart';
import 'package:quiz_app/config/constants.dart';
import 'package:quiz_app/config/theme.dart';

class PostTextWidget extends StatelessWidget {
  final String text;
  const PostTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(Object context) {
    List<TextSpan> textSpans = [];
    text.split(' ').forEach((x) {
      if (x.startsWith('#')) {
        textSpans.add(TextSpan(
          text: '$x ',
          style: textDecorationTextStyle(primary, fontWeight: FontWeight.bold),
        ));
      } else if (x.startsWith('https://') ||
          x.startsWith('http://') ||
          x.startsWith('www.')) {
        textSpans.add(TextSpan(
          text: '$x ',
          style: textDecorationTextStyle(
            primary,
            fontWeight: FontWeight.w500,
            underline: true,
          ),
        ));
      } else {
        textSpans.add(TextSpan(
          text: '$x ',
          style: textDecorationTextStyle(textColor),
        ));
      }
    });
    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
