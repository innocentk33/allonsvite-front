import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride.freezed.dart';
part 'ride.g.dart';

@freezed
sealed class Ride with _$Ride {
  const factory Ride({
    required int id,
    required String pickupSpot,
    required String arrivalSpot,
    required DateTime startAt,
    required DateTime endAt,
    required int price,
    required int numberOfSeats,
  }) = _Ride;

  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);
}

@freezed
sealed class RideSearchParams with _$RideSearchParams {
  const factory RideSearchParams({
    String? fromLocation,
    String? toLocation,
    DateTime? date,
    int? seats,
  }) = _RideSearchParams;
}
