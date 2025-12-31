// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationListController)
const locationListControllerProvider = LocationListControllerProvider._();

final class LocationListControllerProvider
    extends $AsyncNotifierProvider<LocationListController, List<Location>> {
  const LocationListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationListControllerHash();

  @$internal
  @override
  LocationListController create() => LocationListController();
}

String _$locationListControllerHash() =>
    r'ab0a5ca388ebb743db215ae58ac5519c7b98d7c8';

abstract class _$LocationListController extends $AsyncNotifier<List<Location>> {
  FutureOr<List<Location>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Location>>, List<Location>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Location>>, List<Location>>,
              AsyncValue<List<Location>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
