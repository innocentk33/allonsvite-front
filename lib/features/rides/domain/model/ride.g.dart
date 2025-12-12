// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ride _$RideFromJson(Map<String, dynamic> json) => _Ride(
  id: (json['id'] as num).toInt(),
  pickupSpot: json['pickupSpot'] as String,
  arrivalSpot: json['arrivalSpot'] as String,
  startAt: DateTime.parse(json['startAt'] as String),
  endAt: DateTime.parse(json['endAt'] as String),
  price: (json['price'] as num).toInt(),
  numberOfSeats: (json['numberOfSeats'] as num).toInt(),
);

Map<String, dynamic> _$RideToJson(_Ride instance) => <String, dynamic>{
  'id': instance.id,
  'pickupSpot': instance.pickupSpot,
  'arrivalSpot': instance.arrivalSpot,
  'startAt': instance.startAt.toIso8601String(),
  'endAt': instance.endAt.toIso8601String(),
  'price': instance.price,
  'numberOfSeats': instance.numberOfSeats,
};
