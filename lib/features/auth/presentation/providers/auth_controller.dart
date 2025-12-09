import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_providers.dart';
import '../../domain/models/auth_user.dart';

part 'auth_controller.g.dart';

/// Provider pour vérifier l'état d'authentification au démarrage
@riverpod
Future<bool> authCheck(Ref ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final result = await authRepository.isAuthenticated();

  return result.fold(
    (failure) => false,
    (isAuth) => isAuth,
  );
}

/// Provider pour gérer l'état de la demande OTP
@riverpod
class OtpRequest extends _$OtpRequest {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> requestOtp(String phoneNumber) async {
    debugPrint("Requesting OTP for phone number: $phoneNumber");
    state = const AsyncValue.loading();
    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.requestOtp(phoneNumber);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }
}

/// Provider pour gérer l'état de la vérification OTP
@riverpod
class OtpVerification extends _$OtpVerification {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> verifyOtp(String phoneNumber, String otpCode) async {
    state = const AsyncValue.loading();
    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.verifyAndLogin(phoneNumber, otpCode);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {
        state = const AsyncValue.data(null);
        // Mettre à jour l'état de l'utilisateur connecté
        ref.invalidate(authStateProvider);
      },
    );
  }
}

/// Provider pour l'utilisateur connecté
@riverpod
class AuthState extends _$AuthState {
  @override
  Future<AuthUser?> build() async {
    final authRepository = ref.watch(authRepositoryProvider);
    final result = await authRepository.getCurrentUser();

    return result.fold(
      (failure) => null,
      (user) => user,
    );
  }


  /// Déconnexion
  Future<void> logout() async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.logout();
    state = const AsyncValue.data(null);
  }

  /// Rafraîchir l'utilisateur
  Future<void> refresh() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();

    final result = await authRepository.getCurrentUser();

    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (user) => state = AsyncValue.data(user),
    );
  }
}

