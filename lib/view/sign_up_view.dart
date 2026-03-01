import 'package:flutter/material.dart';

import '../core/app_routes.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final lineColor = const Color(0xFFD4DAE4);
    final mutedText = const Color(0xFF8A9AB3);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 440,
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
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
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
              offset: const Offset(0, -38),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'こだわりの暮らしに、\n新しいアカウントを。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          height: 1.35,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF17223A),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '心地よい家具体験を、ここから始めましょう。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: mutedText,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 34),
                      _LineInputField(label: '氏名', lineColor: lineColor),
                      const SizedBox(height: 24),
                      _LineInputField(label: 'メールアドレス', lineColor: lineColor),
                      const SizedBox(height: 24),
                      _LineInputField(
                        label: 'パスワードを作成',
                        lineColor: lineColor,
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xFF93A1B8),
                        ),
                      ),
                      const SizedBox(height: 42),
                      SizedBox(
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFF0E8CD),
                            foregroundColor: const Color(0xFF1B223B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34),
                            ),
                          ),
                          child: const Text(
                            '登録をはじめる  →',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: lineColor, thickness: 1.1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Text(
                              'または連携',
                              style: TextStyle(
                                color: mutedText,
                                fontSize: 14,
                                letterSpacing: 2.2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: lineColor, thickness: 1.1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialCircle(icon: Icons.g_mobiledata),
                          SizedBox(width: 22),
                          _SocialCircle(icon: Icons.apple),
                        ],
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: TextButton(
                          onPressed:
                              () =>
                                  Navigator.pushNamed(context, AppRoutes.logIn),
                          child: const Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF8A9AB3),
                              ),
                              children: [
                                TextSpan(text: 'すでに会員ですか？ '),
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

class _LineInputField extends StatelessWidget {
  const _LineInputField({
    required this.label,
    required this.lineColor,
    this.suffixIcon,
  });

  final String label;
  final Color lineColor;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 16, color: Color(0xFF2A3653)),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontSize: 42 / 2, color: Color(0xFF8A9AB3)),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.only(bottom: 16),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lineColor, width: 1.4),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB8A16E), width: 1.4),
        ),
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  const _SocialCircle({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFDDE3ED), width: 1.2),
        color: const Color(0xFFF8FAFC),
      ),
      child: Icon(icon, color: const Color(0xFF9AA8BE), size: 28),
    );
  }
}
