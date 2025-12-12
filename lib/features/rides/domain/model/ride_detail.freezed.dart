// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RideDetail {

 int get id; String get pickupSpot; String get arrivalSpot; DateTime get startAt; DateTime get endAt; int get price; int get numberOfSeats; Driver get driver;
/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideDetailCopyWith<RideDetail> get copyWith => _$RideDetailCopyWithImpl<RideDetail>(this as RideDetail, _$identity);

  /// Serializes this RideDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.pickupSpot, pickupSpot) || other.pickupSpot == pickupSpot)&&(identical(other.arrivalSpot, arrivalSpot) || other.arrivalSpot == arrivalSpot)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.numberOfSeats, numberOfSeats) || other.numberOfSeats == numberOfSeats)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pickupSpot,arrivalSpot,startAt,endAt,price,numberOfSeats,driver);

@override
String toString() {
  return 'RideDetail(id: $id, pickupSpot: $pickupSpot, arrivalSpot: $arrivalSpot, startAt: $startAt, endAt: $endAt, price: $price, numberOfSeats: $numberOfSeats, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $RideDetailCopyWith<$Res>  {
  factory $RideDetailCopyWith(RideDetail value, $Res Function(RideDetail) _then) = _$RideDetailCopyWithImpl;
@useResult
$Res call({
 int id, String pickupSpot, String arrivalSpot, DateTime startAt, DateTime endAt, int price, int numberOfSeats, Driver driver
});


$DriverCopyWith<$Res> get driver;

}
/// @nodoc
class _$RideDetailCopyWithImpl<$Res>
    implements $RideDetailCopyWith<$Res> {
  _$RideDetailCopyWithImpl(this._self, this._then);

  final RideDetail _self;
  final $Res Function(RideDetail) _then;

/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pickupSpot = null,Object? arrivalSpot = null,Object? startAt = null,Object? endAt = null,Object? price = null,Object? numberOfSeats = null,Object? driver = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pickupSpot: null == pickupSpot ? _self.pickupSpot : pickupSpot // ignore: cast_nullable_to_non_nullable
as String,arrivalSpot: null == arrivalSpot ? _self.arrivalSpot : arrivalSpot // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,numberOfSeats: null == numberOfSeats ? _self.numberOfSeats : numberOfSeats // ignore: cast_nullable_to_non_nullable
as int,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as Driver,
  ));
}
/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverCopyWith<$Res> get driver {
  
  return $DriverCopyWith<$Res>(_self.driver, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}


/// Adds pattern-matching-related methods to [RideDetail].
extension RideDetailPatterns on RideDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideDetail value)  $default,){
final _that = this;
switch (_that) {
case _RideDetail():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideDetail value)?  $default,){
final _that = this;
switch (_that) {
case _RideDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats,  Driver driver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideDetail() when $default != null:
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats,_that.driver);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats,  Driver driver)  $default,) {final _that = this;
switch (_that) {
case _RideDetail():
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats,_that.driver);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats,  Driver driver)?  $default,) {final _that = this;
switch (_that) {
case _RideDetail() when $default != null:
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats,_that.driver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RideDetail implements RideDetail {
  const _RideDetail({required this.id, required this.pickupSpot, required this.arrivalSpot, required this.startAt, required this.endAt, required this.price, required this.numberOfSeats, required this.driver});
  factory _RideDetail.fromJson(Map<String, dynamic> json) => _$RideDetailFromJson(json);

@override final  int id;
@override final  String pickupSpot;
@override final  String arrivalSpot;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  int price;
@override final  int numberOfSeats;
@override final  Driver driver;

/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideDetailCopyWith<_RideDetail> get copyWith => __$RideDetailCopyWithImpl<_RideDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.pickupSpot, pickupSpot) || other.pickupSpot == pickupSpot)&&(identical(other.arrivalSpot, arrivalSpot) || other.arrivalSpot == arrivalSpot)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.numberOfSeats, numberOfSeats) || other.numberOfSeats == numberOfSeats)&&(identical(other.driver, driver) || other.driver == driver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pickupSpot,arrivalSpot,startAt,endAt,price,numberOfSeats,driver);

@override
String toString() {
  return 'RideDetail(id: $id, pickupSpot: $pickupSpot, arrivalSpot: $arrivalSpot, startAt: $startAt, endAt: $endAt, price: $price, numberOfSeats: $numberOfSeats, driver: $driver)';
}


}

/// @nodoc
abstract mixin class _$RideDetailCopyWith<$Res> implements $RideDetailCopyWith<$Res> {
  factory _$RideDetailCopyWith(_RideDetail value, $Res Function(_RideDetail) _then) = __$RideDetailCopyWithImpl;
@override @useResult
$Res call({
 int id, String pickupSpot, String arrivalSpot, DateTime startAt, DateTime endAt, int price, int numberOfSeats, Driver driver
});


@override $DriverCopyWith<$Res> get driver;

}
/// @nodoc
class __$RideDetailCopyWithImpl<$Res>
    implements _$RideDetailCopyWith<$Res> {
  __$RideDetailCopyWithImpl(this._self, this._then);

  final _RideDetail _self;
  final $Res Function(_RideDetail) _then;

/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pickupSpot = null,Object? arrivalSpot = null,Object? startAt = null,Object? endAt = null,Object? price = null,Object? numberOfSeats = null,Object? driver = null,}) {
  return _then(_RideDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pickupSpot: null == pickupSpot ? _self.pickupSpot : pickupSpot // ignore: cast_nullable_to_non_nullable
as String,arrivalSpot: null == arrivalSpot ? _self.arrivalSpot : arrivalSpot // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,numberOfSeats: null == numberOfSeats ? _self.numberOfSeats : numberOfSeats // ignore: cast_nullable_to_non_nullable
as int,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as Driver,
  ));
}

/// Create a copy of RideDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DriverCopyWith<$Res> get driver {
  
  return $DriverCopyWith<$Res>(_self.driver, (value) {
    return _then(_self.copyWith(driver: value));
  });
}
}

// dart format on
