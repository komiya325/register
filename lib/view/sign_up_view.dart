import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/app_routes.dart';
import '../provider/auth_provider.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 420,
                  width: double.infinity,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1616486029423-aaa4789e8c9a?auto=format&fit=crop&w=1400&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, top: 8),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF1A2742),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -34),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '新規登録',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17223A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Googleアカウントでそのまま登録できます。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8A9AB3),
                        ),
                      ),
                      const SizedBox(height: 34),
                      SizedBox(
                        height: 62,
                        child: ElevatedButton.icon(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : () async {
                                    final ok =
                                        await ref
                                            .read(
                                              registerViewModelProvider
                                                  .notifier,
                                            )
                                            .registerWithGoogle();
                                    if (ok && context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.home,
                                        (route) => false,
                                      );
                                    }
                                  },
                          icon: const Icon(Icons.g_mobiledata, size: 32),
                          label:
                              state.isLoading
                                  ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Text(
                                    'Googleで新規登録',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFF0E8CD),
                            foregroundColor: const Color(0xFF1B223B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (state.errorMessage != null)
                        Text(
                          state.errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed:
                            () => Navigator.pushNamed(context, AppRoutes.logIn),
                        child: const Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8A9AB3),
                            ),
                            children: [
                              TextSpan(text: 'すでにアカウントをお持ちですか？ '),
                              TextSpan(
                                text: 'ログイン',
                                style: TextStyle(
                                  color: Color(0xFFC89E35),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
