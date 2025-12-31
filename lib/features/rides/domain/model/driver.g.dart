// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Driver _$DriverFromJson(Map<String, dynamic> json) => _Driver(
  id: (json['id'] as num).toInt(),
  phone: json['phone'] as String,
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
);

Map<String, dynamic> _$DriverToJson(_Driver instance) => <String, dynamic>{
  'id': instance.id,
  'phone': instance.phone,
  'firstname': instance.firstname,
  'lastname': instance.lastname,
};
