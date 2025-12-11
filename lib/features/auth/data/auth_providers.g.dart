// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'e74b8add9e3612bacbe713cb817c434906039a54';

@ProviderFor(authLocalRepository)
const authLocalRepositoryProvider = AuthLocalRepositoryProvider._();

final class AuthLocalRepositoryProvider
    extends
        $FunctionalProvider<
          AuthLocalRepository,
          AuthLocalRepository,
          AuthLocalRepository
        >
    with $Provider<AuthLocalRepository> {
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
    r'5e1ef93eb03a9014473ff9af3b418a61c0f441d4';

@ProviderFor(authRemoteRepository)
const authRemoteRepositoryProvider = AuthRemoteRepositoryProvider._();

final class AuthRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          AuthRemoteRepository,
          AuthRemoteRepository,
          AuthRemoteRepository
        >
    with $Provider<AuthRemoteRepository> {
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
    r'681cc87dd1957b7902a5bebce2d2719dee9ae637';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
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
