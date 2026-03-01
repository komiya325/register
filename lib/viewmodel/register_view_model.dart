import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import 'auth_action_state.dart';

class RegisterViewModel extends StateNotifier<AuthActionState> {
  RegisterViewModel(this._authRepository) : super(const AuthActionState());

  final AuthRepository _authRepository;

  Future<bool> registerWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final user = await _authRepository.signInWithGoogle();
      final exists = await _authRepository.checkUserExists(user.uid);

      if (!exists) {
        await _authRepository.saveUser(user);
      }

      state = state.copyWith(isLoading: false, clearError: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}
