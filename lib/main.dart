import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'view/first_view.dart';
import 'view/log_in_view.dart';
import 'view/sign_up_view.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Join Us',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'SF Pro Display',
      ),
      initialRoute: AppRoutes.first,
      routes: {
        AppRoutes.first: (_) => const FirstView(),
        AppRoutes.signUp: (_) => const SignUpView(),
        AppRoutes.logIn: (_) => const LogInView(),
      },
    );
  }
}
