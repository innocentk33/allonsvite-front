import 'package:allonsvite/features/rides/domain/model/ride.dart';
import 'package:allonsvite/features/rides/domain/model/ride_detail.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/network/api_error_handler.dart';

import '../../domain/repositories/ride_repository.dart';
import '../datasources/ride_remote_datasource.dart';

class RideRepositoryImpl implements RideRepository {
  final RideRemoteDataSource _remoteDataSource;

  RideRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Ride>>> getRides(RideSearchParams params) async {
    try {
      final rides = await _remoteDataSource.getRides(params);
      return right(rides);
    } on DioException catch (e) {
      return left(ApiErrorHandler.handleDioError(e));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RideDetail>> getRideDetail(int id) async {
    try {
      final ride = await _remoteDataSource.getRideDetail(id);
      return right(ride);
    } on DioException catch (e) {
      return left(ApiErrorHandler.handleDioError(e));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
