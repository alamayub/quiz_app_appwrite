import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/auth_controller.dart';
import 'package:quiz_app/screens/login_screen.dart';
import 'package:quiz_app/screens/quiz_app.dart';
import 'package:quiz_app/widgets/custom_text_widget.dart';
import 'package:quiz_app/widgets/loader.dart';

import 'config/constants.dart';
import 'config/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      navigatorKey: navigatorKey,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) =>
                user != null ? const QuizApp() : const LoginScreen(),
            error: (error, stackTrace) => Scaffold(
              body: CustomTextWidget(
                title: error.toString(),
              ),
            ),
            loading: () => const Scaffold(
              body: Loader(),
            ),
          ),
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
