// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationRemoteDataSource)
const locationRemoteDataSourceProvider = LocationRemoteDataSourceProvider._();

final class LocationRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LocationRemoteDataSource,
          LocationRemoteDataSource,
          LocationRemoteDataSource
        >
    with $Provider<LocationRemoteDataSource> {
  const LocationRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LocationRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRemoteDataSource create(Ref ref) {
    return locationRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRemoteDataSource>(value),
    );
  }
}

String _$locationRemoteDataSourceHash() =>
    r'5513c113e2bb3a71e1645f7f7cbd83de256dbe7d';

@ProviderFor(locationRepository)
const locationRepositoryProvider = LocationRepositoryProvider._();

final class LocationRepositoryProvider
    extends
        $FunctionalProvider<
          LocationRepository,
          LocationRepository,
          LocationRepository
        >
    with $Provider<LocationRepository> {
  const LocationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRepository create(Ref ref) {
    return locationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRepository>(value),
    );
  }
}

String _$locationRepositoryHash() =>
    r'5f72f73eb18962ae2023274b807695f22fdf0462';

@ProviderFor(rideRemoteDataSource)
const rideRemoteDataSourceProvider = RideRemoteDataSourceProvider._();

final class RideRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          RideRemoteDataSource,
          RideRemoteDataSource,
          RideRemoteDataSource
        >
    with $Provider<RideRemoteDataSource> {
  const RideRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<RideRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RideRemoteDataSource create(Ref ref) {
    return rideRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideRemoteDataSource>(value),
    );
  }
}

String _$rideRemoteDataSourceHash() =>
    r'cbd3a787c1b8c94c6f214d3e7abf469c8fee357a';

@ProviderFor(rideRepository)
const rideRepositoryProvider = RideRepositoryProvider._();

final class RideRepositoryProvider
    extends $FunctionalProvider<RideRepository, RideRepository, RideRepository>
    with $Provider<RideRepository> {
  const RideRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideRepositoryHash();

  @$internal
  @override
  $ProviderElement<RideRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RideRepository create(Ref ref) {
    return rideRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideRepository>(value),
    );
  }
}

String _$rideRepositoryHash() => r'eb66991c330fe3b9e2500a10adeeef1ffcd22146';
