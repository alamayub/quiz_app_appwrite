import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/auth_controller.dart';

import '../widgets/auth_text_form_widget.dart';
import '../widgets/auth_toggle_text_widget.dart';
import '../widgets/custom_material_button_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  void _signUp() {
    FocusScope.of(context).unfocus();
    ref.read(authControllerProvider.notifier).signUp(
          name: _name.text.trim(),
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
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              LoginFormInputWidget(
                controller: _name,
                title: 'Full Name*',
                hint: 'John Doe',
              ),
              const SizedBox(height: 12),
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
                title: 'Register',
                onPressed: _signUp,
              ),
              const Spacer(),
              const AuthToggleTextWidget(
                title: 'Login',
                subTitle: 'Already have an account? ',
                isLog: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
