import 'package:allonsvite/core/constant/app_constant.dart';
import 'package:dio/dio.dart';
import '../../../../core/model/api_response.dart';
import '../../domain/ride.dart';

class RideRemoteDataSource {
  final Dio _dio;

  RideRemoteDataSource(this._dio);

  Future<List<Ride>> getRides(RideSearchParams params) async {
    final Map<String, dynamic> queryParams = {};
    if (params.fromLocation != null) queryParams['from'] = params.fromLocation;
    if (params.toLocation != null) queryParams['to'] = params.toLocation;
    if (params.date != null){
      queryParams['date'] = params.date!.toIso8601String();
    }
    if (params.seats != null) queryParams['seats'] = params.seats;
    final response = await _dio.get(AppConstant.rides, queryParameters: queryParams);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.data.map((json) => Ride.fromJson(json)).toList();
    } else {
      throw Exception('Impossible de récupérer les trajets');
    }
  }
}
