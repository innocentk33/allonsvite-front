import 'package:allonsvite/core/constant/app_constant.dart';
import 'package:allonsvite/core/model/api_response.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/location.dart';

part 'location_remote_datasource.g.dart';

@riverpod
LocationRemoteDataSource locationRemoteDataSource(Ref ref) {
  throw UnimplementedError('Provider not initialized');
}

class LocationRemoteDataSource {
  final Dio _dio;

  LocationRemoteDataSource(this._dio);

  Future<List<Location>> getLocations() async {
    final response = await _dio.get(AppConstant.locations);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.data.map((json) => Location.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
