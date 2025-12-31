import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
sealed class Driver with _$Driver {
  const factory Driver({
    required int id,
    required String phone,
    required String firstname,
    required String lastname,
  }) = _Driver;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}



