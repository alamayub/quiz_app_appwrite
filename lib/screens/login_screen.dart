import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import '../widgets/auth_text_form_widget.dart';
import '../widgets/auth_toggle_text_widget.dart';
import '../widgets/custom_material_button_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    ref.read(authControllerProvider.notifier).login(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    var loading = ref.watch(authControllerProvider);
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return !loading;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              LoginFormInputWidget(
                controller: _email,
                title: 'Email Address*',
                hint: 'example@example.com',
              ),
              const SizedBox(height: 12),
              LoginFormInputWidget(
                controller: _password,
                title: 'Password*',
                hint: '********',
              ),
              const SizedBox(height: 20),
              CustomMaterialButtonWidget(
                loading: loading,
                title: 'Login',
                onPressed: _login,
              ),
              const Spacer(),
              const AuthToggleTextWidget(
                title: 'Register',
                subTitle: 'Don\'t have an account? ',
                isLog: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
