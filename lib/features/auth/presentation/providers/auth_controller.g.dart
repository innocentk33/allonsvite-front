// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour vérifier l'état d'authentification au démarrage

@ProviderFor(authCheck)
const authCheckProvider = AuthCheckProvider._();

/// Provider pour vérifier l'état d'authentification au démarrage

final class AuthCheckProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Provider pour vérifier l'état d'authentification au démarrage
  const AuthCheckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCheckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCheckHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return authCheck(ref);
  }
}

String _$authCheckHash() => r'10005db0d10d889d87932dc13156e7f07f2daa39';

/// Provider pour gérer l'état de la demande OTP

@ProviderFor(OtpRequest)
const otpRequestProvider = OtpRequestProvider._();

/// Provider pour gérer l'état de la demande OTP
final class OtpRequestProvider
    extends $NotifierProvider<OtpRequest, AsyncValue<void>> {
  /// Provider pour gérer l'état de la demande OTP
  const OtpRequestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpRequestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpRequestHash();

  @$internal
  @override
  OtpRequest create() => OtpRequest();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$otpRequestHash() => r'f1dd67f63f4197fdfeb66590555a18175b105da9';

/// Provider pour gérer l'état de la demande OTP

abstract class _$OtpRequest extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour gérer l'état de la vérification OTP

@ProviderFor(OtpVerification)
const otpVerificationProvider = OtpVerificationProvider._();

/// Provider pour gérer l'état de la vérification OTP
final class OtpVerificationProvider
    extends $NotifierProvider<OtpVerification, AsyncValue<void>> {
  /// Provider pour gérer l'état de la vérification OTP
  const OtpVerificationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpVerificationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpVerificationHash();

  @$internal
  @override
  OtpVerification create() => OtpVerification();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$otpVerificationHash() => r'c818ad83098c84c7d956e4fdb0eaf56d463b0c63';

/// Provider pour gérer l'état de la vérification OTP

abstract class _$OtpVerification extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour l'utilisateur connecté

@ProviderFor(AuthState)
const authStateProvider = AuthStateProvider._();

/// Provider pour l'utilisateur connecté
final class AuthStateProvider
    extends $AsyncNotifierProvider<AuthState, AuthUser?> {
  /// Provider pour l'utilisateur connecté
  const AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  AuthState create() => AuthState();
}

String _$authStateHash() => r'22a861589cf6b1a586f4a5f66579c02f63d4c592';

/// Provider pour l'utilisateur connecté

abstract class _$AuthState extends $AsyncNotifier<AuthUser?> {
  FutureOr<AuthUser?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<AuthUser?>, AuthUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthUser?>, AuthUser?>,
              AsyncValue<AuthUser?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
