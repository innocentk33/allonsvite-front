// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideDetailController)
const rideDetailControllerProvider = RideDetailControllerFamily._();

final class RideDetailControllerProvider
    extends $AsyncNotifierProvider<RideDetailController, RideDetail> {
  const RideDetailControllerProvider._({
    required RideDetailControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'rideDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rideDetailControllerHash();

  @override
  String toString() {
    return r'rideDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RideDetailController create() => RideDetailController();

  @override
  bool operator ==(Object other) {
    return other is RideDetailControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rideDetailControllerHash() =>
    r'e22fbd4ca2cefb1a4ed9063c2ee2af7e740c22b4';

final class RideDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          RideDetailController,
          AsyncValue<RideDetail>,
          RideDetail,
          FutureOr<RideDetail>,
          int
        > {
  const RideDetailControllerFamily._()
    : super(
        retry: null,
        name: r'rideDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RideDetailControllerProvider call(int id) =>
      RideDetailControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'rideDetailControllerProvider';
}

abstract class _$RideDetailController extends $AsyncNotifier<RideDetail> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<RideDetail> build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<RideDetail>, RideDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RideDetail>, RideDetail>,
              AsyncValue<RideDetail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
