import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import 'first_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authUserProvider);
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ホーム'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: authUser.when(
          data: (user) {
            if (user == null) {
              return const Center(child: Text('ユーザー情報がありません。'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 44,
                  backgroundImage:
                      user.photoUrl.isNotEmpty
                          ? NetworkImage(user.photoUrl)
                          : null,
                  child:
                      user.photoUrl.isEmpty
                          ? Text(
                            user.name.isNotEmpty ? user.name[0] : '?',
                            style: const TextStyle(fontSize: 28),
                          )
                          : null,
                ),
                const SizedBox(height: 20),
                Text(
                  user.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF6B7A93),
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        state.isLoading
                            ? null
                            : () async {
                              await ref
                                  .read(homeViewModelProvider.notifier)
                                  .signOut();
                              if (context.mounted) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) => const FirstView(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                    child:
                        state.isLoading
                            ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : const Text('ログアウト'),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('エラー: $error')),
        ),
      ),
    );
  }
}
