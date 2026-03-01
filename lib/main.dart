import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_routes.dart';
import 'view/first_view.dart';
import 'view/home_view.dart';
import 'view/log_in_view.dart';
import 'view/sign_up_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<FirebaseApp> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _initializeFirebase();
  }

  Future<FirebaseApp> _initializeFirebase() async {
    try {
      return await Firebase.initializeApp();
    } catch (_) {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
        return Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyCnbVkH5Rv0FcpRdorlOYN5dgRNsq385HY',
            appId: '1:567215382472:ios:0c2a246fc6c78d8d1f6afd',
            messagingSenderId: '567215382472',
            projectId: 'register-app-4103e',
            storageBucket: 'register-app-4103e.firebasestorage.app',
            iosBundleId: 'com.membersip.register',
          ),
        );
      }
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Register App',
      routes: {
        AppRoutes.signUp: (_) => const SignUpView(),
        AppRoutes.logIn: (_) => const LogInView(),
        AppRoutes.home: (_) => const HomeView(),
      },
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Firebase初期化エラー: ${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }

          return const FirstView();
        },
      ),
    );
  }
}
