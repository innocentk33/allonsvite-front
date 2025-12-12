import 'package:allonsvite/features/rides/domain/model/driver.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_detail.freezed.dart';
part 'ride_detail.g.dart';


@freezed
sealed class RideDetail with _$RideDetail {
  const factory RideDetail({
    required int id,
    required String pickupSpot,
    required String arrivalSpot,
    required DateTime startAt,
    required DateTime endAt,
    required int price,
    required int numberOfSeats,
    required Driver driver,
  }) = _RideDetail;

  factory RideDetail.fromJson(Map<String, dynamic> json) => _$RideDetailFromJson(json);
}