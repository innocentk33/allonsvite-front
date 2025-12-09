// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour AuthLocalRepository

@ProviderFor(authLocalRepository)
const authLocalRepositoryProvider = AuthLocalRepositoryProvider._();

/// Provider pour AuthLocalRepository

final class AuthLocalRepositoryProvider
    extends
        $FunctionalProvider<
          AuthLocalRepository,
          AuthLocalRepository,
          AuthLocalRepository
        >
    with $Provider<AuthLocalRepository> {
  /// Provider pour AuthLocalRepository
  const AuthLocalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthLocalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLocalRepository create(Ref ref) {
    return authLocalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalRepository>(value),
    );
  }
}

String _$authLocalRepositoryHash() =>
    r'fa4d89725d83f90fb8e6df3c97165b8f87d4f4b6';

/// Provider pour AuthRemoteRepository

@ProviderFor(authRemoteRepository)
const authRemoteRepositoryProvider = AuthRemoteRepositoryProvider._();

/// Provider pour AuthRemoteRepository

final class AuthRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          AuthRemoteRepository,
          AuthRemoteRepository,
          AuthRemoteRepository
        >
    with $Provider<AuthRemoteRepository> {
  /// Provider pour AuthRemoteRepository
  const AuthRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteRepository create(Ref ref) {
    return authRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteRepository>(value),
    );
  }
}

String _$authRemoteRepositoryHash() =>
    r'93a60d68a9dc12754e90eb63bcfe767a9ef3a45e';

/// Provider pour AuthRepository (l'orchestrateur)

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// Provider pour AuthRepository (l'orchestrateur)

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Provider pour AuthRepository (l'orchestrateur)
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'239bc929c826c41a66afa0bb9955a1fa84b2132d';
