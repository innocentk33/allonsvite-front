import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_local_repository.dart';
import 'auth_remote_repository.dart';
import 'auth_repository.dart';

import '../../../core/network/dio_providers.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'SharedPreferences doit être initialisé dans le main',
  );
}

// Provider pour AuthLocalRepository
@riverpod
AuthLocalRepository authLocalRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalRepository(const FlutterSecureStorage(), prefs);
}

// Provider pour AuthRemoteRepository
@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  final dio = ref.watch(dioProvider);
  return AuthRemoteRepository(dio);
}

// Provider pour AuthRepository (l'orchestrateur)
@riverpod
AuthRepository authRepository(Ref ref) {
  final localRepository = ref.watch(authLocalRepositoryProvider);
  final remoteRepository = ref.watch(authRemoteRepositoryProvider);
  return AuthRepository(localRepository, remoteRepository);
}
