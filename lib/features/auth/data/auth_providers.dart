import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constant/app_constant.dart';
import 'auth_local_repository.dart';
import 'auth_remote_repository.dart';
import 'auth_repository.dart';

part 'auth_providers.g.dart';
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError('SharedPreferences doit être initialisé dans le main');
}
/// Fonction factory pour créer une instance Dio configurée
Dio _createAuthDio() {
  return Dio(
    BaseOptions(
      baseUrl: AppConstant.apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}

/// Provider pour AuthLocalRepository
@riverpod
AuthLocalRepository authLocalRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalRepository(const FlutterSecureStorage(),prefs);
}

/// Provider pour AuthRemoteRepository
@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository(_createAuthDio());
}

/// Provider pour AuthRepository (l'orchestrateur)
@riverpod
AuthRepository authRepository(Ref ref) {
  final localRepository = ref.watch(authLocalRepositoryProvider);
  final remoteRepository = ref.watch(authRemoteRepositoryProvider);
  return AuthRepository(localRepository, remoteRepository);
}

