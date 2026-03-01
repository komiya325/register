import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';
import '../viewmodel/auth_action_state.dart';
import '../viewmodel/home_view_model.dart';
import '../viewmodel/login_view_model.dart';
import '../viewmodel/register_view_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authUserProvider = StreamProvider<UserEntity?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

final registerViewModelProvider =
    StateNotifierProvider<RegisterViewModel, AuthActionState>((ref) {
      return RegisterViewModel(ref.watch(authRepositoryProvider));
    });

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AuthActionState>((ref) {
      return LoginViewModel(ref.watch(authRepositoryProvider));
    });

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AuthActionState>((ref) {
      return HomeViewModel(ref.watch(authRepositoryProvider));
    });
