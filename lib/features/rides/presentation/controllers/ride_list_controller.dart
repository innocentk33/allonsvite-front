import 'package:allonsvite/features/rides/domain/model/ride.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/feature_providers.dart';

part 'ride_list_controller.g.dart';

@riverpod
Future<List<Ride>> rideListController(Ref ref, RideSearchParams params) async {
  final repository = ref.watch(rideRepositoryProvider);
  final result = await repository.getRides(params);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (rides) => rides,
  );
}
