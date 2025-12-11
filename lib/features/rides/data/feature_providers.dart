import 'package:allonsvite/features/rides/domain/repositories/location_repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'datasources/location_remote_datasource.dart';
import 'datasources/ride_remote_datasource.dart';
import 'repositories/location_repository_impl.dart';
import 'repositories/ride_repository_impl.dart';

import '../domain/repositories/ride_repository.dart';

import '../../../core/network/dio_providers.dart';

part 'feature_providers.g.dart';

@riverpod
LocationRemoteDataSource locationRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return LocationRemoteDataSource(dio);
}

@riverpod
LocationRepository locationRepository(Ref ref) {
  final remoteDataSource = ref.watch(locationRemoteDataSourceProvider);
  return LocationRepositoryImpl(remoteDataSource);
}

// --- RIDES PROVIDERS ---

@riverpod
RideRemoteDataSource rideRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return RideRemoteDataSource(dio);
}

@riverpod
RideRepository rideRepository(Ref ref) {
  final remoteDataSource = ref.watch(rideRemoteDataSourceProvider);
  return RideRepositoryImpl(remoteDataSource);
}
