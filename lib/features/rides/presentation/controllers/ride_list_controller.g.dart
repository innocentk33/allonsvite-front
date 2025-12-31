// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideListController)
const rideListControllerProvider = RideListControllerFamily._();

final class RideListControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ride>>,
          List<Ride>,
          FutureOr<List<Ride>>
        >
    with $FutureModifier<List<Ride>>, $FutureProvider<List<Ride>> {
  const RideListControllerProvider._({
    required RideListControllerFamily super.from,
    required RideSearchParams super.argument,
  }) : super(
         retry: null,
         name: r'rideListControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rideListControllerHash();

  @override
  String toString() {
    return r'rideListControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Ride>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Ride>> create(Ref ref) {
    final argument = this.argument as RideSearchParams;
    return rideListController(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RideListControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rideListControllerHash() =>
    r'3ac81baa1c459daa67d5e054362147c12789b083';

final class RideListControllerFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Ride>>, RideSearchParams> {
  const RideListControllerFamily._()
    : super(
        retry: null,
        name: r'rideListControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RideListControllerProvider call(RideSearchParams params) =>
      RideListControllerProvider._(argument: params, from: this);

  @override
  String toString() => r'rideListControllerProvider';
}
