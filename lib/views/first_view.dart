import 'package:flutter/material.dart';

import '../routes.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'https://images.unsplash.com/photo-1617104551722-3b2d51366400?auto=format&fit=crop&w=1400&q=80',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 420,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0x9A11182A), Color(0x0011182A)],
                    ),
                  ),
                ),
                const Positioned(
                  left: 28,
                  right: 28,
                  bottom: 34,
                  child: Text(
                    '住まいを彩る\n特別な体験を。',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 26, 28, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'はじめる',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF17223A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '新規登録またはログインを選択してください。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8797AF),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 34),
                      SizedBox(
                        height: 64,
                        child: ElevatedButton(
                          onPressed:
                              () => Navigator.pushNamed(
                                context,
                                AppRoutes.signUp,
                              ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFF0E8CD),
                            foregroundColor: const Color(0xFF1B223B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                          ),
                          child: const Text(
                            '新規登録する  →',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 64,
                        child: OutlinedButton(
                          onPressed:
                              () =>
                                  Navigator.pushNamed(context, AppRoutes.logIn),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFD7DEE9),
                              width: 1.4,
                            ),
                            foregroundColor: const Color(0xFF1F2C48),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                          ),
                          child: const Text(
                            'ログイン',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'インテリア好きのための限定コミュニティへ。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF95A3B8),
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
