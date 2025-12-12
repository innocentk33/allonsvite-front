import 'package:allonsvite/features/rides/domain/model/ride_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/feature_providers.dart';

part 'ride_detail_controller.g.dart';

@riverpod
class RideDetailController extends _$RideDetailController {
  @override
  FutureOr<RideDetail> build(int id) async {
    final repo = ref.watch(rideRepositoryProvider);
    final result = await repo.getRideDetail(id);

    return result.fold(
      (failure) => throw Exception(failure.message),
      (ride) => ride,
    );
  }
}
