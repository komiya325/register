import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import 'auth_action_state.dart';

class LoginViewModel extends StateNotifier<AuthActionState> {
  LoginViewModel(this._authRepository) : super(const AuthActionState());

  final AuthRepository _authRepository;

  Future<bool> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final user = await _authRepository.signInWithGoogle();
      final exists = await _authRepository.checkUserExists(user.uid);

      if (!exists) {
        await _authRepository.signOut();
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'このアカウントは未登録です。新規登録から進めてください。',
        );
        return false;
      }

      state = state.copyWith(isLoading: false, clearError: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}
