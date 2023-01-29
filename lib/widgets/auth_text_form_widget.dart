import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text_widget.dart';

class LoginFormInputWidget extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const LoginFormInputWidget({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          title: title,
          fontSize: 14,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
          ),
        ),
      ],
    );
  }
}