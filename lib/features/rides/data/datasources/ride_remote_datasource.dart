import 'package:allonsvite/core/constant/app_constant.dart';
import 'package:allonsvite/features/rides/domain/model/ride.dart';
import 'package:allonsvite/features/rides/domain/model/ride_detail.dart';
import 'package:dio/dio.dart';
import '../../../../core/model/api_response.dart';

class RideRemoteDataSource {
  final Dio _dio;

  RideRemoteDataSource(this._dio);

  Future<List<Ride>> getRides(RideSearchParams params) async {
    final Map<String, dynamic> queryParams = {};
    if (params.fromLocation != null) queryParams['from'] = params.fromLocation;
    if (params.toLocation != null) queryParams['to'] = params.toLocation;
    if (params.date != null) {
      queryParams['date'] = params.date!.toIso8601String();
    }
    if (params.seats != null) queryParams['seats'] = params.seats;
    final response = await _dio.get(
      AppConstant.rides,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final apiResponse = ApiResponse<List<Ride>>.fromJson(
        response.data,
        (data) => (data as List)
            .map((e) => Ride.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      return apiResponse.data;
    } else {
      throw Exception('Impossible de récupérer les trajets');
    }
  }

  Future<RideDetail> getRideDetail(int id) async {
    final response = await _dio.get('${AppConstant.rides}/$id');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final apiResponse = ApiResponse<RideDetail>.fromJson(
        response.data,
        (data) => RideDetail.fromJson(data as Map<String, dynamic>),
      );
      return apiResponse.data;
    } else {
      throw Exception('Impossible de récupérer le détail du trajet');
    }
  }
}
