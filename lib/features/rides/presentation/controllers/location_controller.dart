import 'package:allonsvite/features/rides/data/feature_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/location.dart';

part 'location_controller.g.dart';

@riverpod
class LocationListController extends _$LocationListController {
  @override
  FutureOr<List<Location>> build() async {
    return _fetchLocations();
  }

  Future<List<Location>> _fetchLocations() async {
    final repository = ref.read(locationRepositoryProvider);
    final result = await repository.getLocations();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (locations) => locations,
    );
  }
}
