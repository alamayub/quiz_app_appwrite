import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../config/constants.dart';
import '../config/theme.dart';
import '../screens/register_screen.dart';

class AuthToggleTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isLog;
  const AuthToggleTextWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.isLog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: subTitle,
        style: textDecorationTextStyle(Colors.grey),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: textDecorationTextStyle(
              primary,
              fontWeight: FontWeight.w500,
            ),
            recognizer: TapGestureRecognizer()..onTap = () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isLog ? const RegisterScreen() : const LoginScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
