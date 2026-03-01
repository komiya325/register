import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';
import 'auth_action_state.dart';

class HomeViewModel extends StateNotifier<AuthActionState> {
  HomeViewModel(this._authRepository) : super(const AuthActionState());

  final AuthRepository _authRepository;

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _authRepository.signOut();
      state = state.copyWith(isLoading: false, clearError: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
