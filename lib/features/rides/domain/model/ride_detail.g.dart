// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RideDetail _$RideDetailFromJson(Map<String, dynamic> json) => _RideDetail(
  id: (json['id'] as num).toInt(),
  pickupSpot: json['pickupSpot'] as String,
  arrivalSpot: json['arrivalSpot'] as String,
  startAt: DateTime.parse(json['startAt'] as String),
  endAt: DateTime.parse(json['endAt'] as String),
  price: (json['price'] as num).toInt(),
  numberOfSeats: (json['numberOfSeats'] as num).toInt(),
  driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RideDetailToJson(_RideDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pickupSpot': instance.pickupSpot,
      'arrivalSpot': instance.arrivalSpot,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'price': instance.price,
      'numberOfSeats': instance.numberOfSeats,
      'driver': instance.driver,
    };
