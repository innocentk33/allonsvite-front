import 'package:allonsvite/core/exceptions/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_datasource.dart';

import 'package:dio/dio.dart';
import '../../../../core/network/api_error_handler.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource _remoteDataSource;

  LocationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Location>>> getLocations() async {
    try {
      final locations = await _remoteDataSource.getLocations();
     
      return right(locations);
    } on DioException catch (e) {
      return left(ApiErrorHandler.handleDioError(e));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
