// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ride {

 int get id; String get pickupSpot; String get arrivalSpot; DateTime get startAt; DateTime get endAt; int get price; int get numberOfSeats;
/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideCopyWith<Ride> get copyWith => _$RideCopyWithImpl<Ride>(this as Ride, _$identity);

  /// Serializes this Ride to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ride&&(identical(other.id, id) || other.id == id)&&(identical(other.pickupSpot, pickupSpot) || other.pickupSpot == pickupSpot)&&(identical(other.arrivalSpot, arrivalSpot) || other.arrivalSpot == arrivalSpot)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.numberOfSeats, numberOfSeats) || other.numberOfSeats == numberOfSeats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pickupSpot,arrivalSpot,startAt,endAt,price,numberOfSeats);

@override
String toString() {
  return 'Ride(id: $id, pickupSpot: $pickupSpot, arrivalSpot: $arrivalSpot, startAt: $startAt, endAt: $endAt, price: $price, numberOfSeats: $numberOfSeats)';
}


}

/// @nodoc
abstract mixin class $RideCopyWith<$Res>  {
  factory $RideCopyWith(Ride value, $Res Function(Ride) _then) = _$RideCopyWithImpl;
@useResult
$Res call({
 int id, String pickupSpot, String arrivalSpot, DateTime startAt, DateTime endAt, int price, int numberOfSeats
});




}
/// @nodoc
class _$RideCopyWithImpl<$Res>
    implements $RideCopyWith<$Res> {
  _$RideCopyWithImpl(this._self, this._then);

  final Ride _self;
  final $Res Function(Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pickupSpot = null,Object? arrivalSpot = null,Object? startAt = null,Object? endAt = null,Object? price = null,Object? numberOfSeats = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pickupSpot: null == pickupSpot ? _self.pickupSpot : pickupSpot // ignore: cast_nullable_to_non_nullable
as String,arrivalSpot: null == arrivalSpot ? _self.arrivalSpot : arrivalSpot // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,numberOfSeats: null == numberOfSeats ? _self.numberOfSeats : numberOfSeats // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Ride].
extension RidePatterns on Ride {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ride value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ride value)  $default,){
final _that = this;
switch (_that) {
case _Ride():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ride value)?  $default,){
final _that = this;
switch (_that) {
case _Ride() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats)  $default,) {final _that = this;
switch (_that) {
case _Ride():
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String pickupSpot,  String arrivalSpot,  DateTime startAt,  DateTime endAt,  int price,  int numberOfSeats)?  $default,) {final _that = this;
switch (_that) {
case _Ride() when $default != null:
return $default(_that.id,_that.pickupSpot,_that.arrivalSpot,_that.startAt,_that.endAt,_that.price,_that.numberOfSeats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ride implements Ride {
  const _Ride({required this.id, required this.pickupSpot, required this.arrivalSpot, required this.startAt, required this.endAt, required this.price, required this.numberOfSeats});
  factory _Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

@override final  int id;
@override final  String pickupSpot;
@override final  String arrivalSpot;
@override final  DateTime startAt;
@override final  DateTime endAt;
@override final  int price;
@override final  int numberOfSeats;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideCopyWith<_Ride> get copyWith => __$RideCopyWithImpl<_Ride>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RideToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ride&&(identical(other.id, id) || other.id == id)&&(identical(other.pickupSpot, pickupSpot) || other.pickupSpot == pickupSpot)&&(identical(other.arrivalSpot, arrivalSpot) || other.arrivalSpot == arrivalSpot)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.price, price) || other.price == price)&&(identical(other.numberOfSeats, numberOfSeats) || other.numberOfSeats == numberOfSeats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pickupSpot,arrivalSpot,startAt,endAt,price,numberOfSeats);

@override
String toString() {
  return 'Ride(id: $id, pickupSpot: $pickupSpot, arrivalSpot: $arrivalSpot, startAt: $startAt, endAt: $endAt, price: $price, numberOfSeats: $numberOfSeats)';
}


}

/// @nodoc
abstract mixin class _$RideCopyWith<$Res> implements $RideCopyWith<$Res> {
  factory _$RideCopyWith(_Ride value, $Res Function(_Ride) _then) = __$RideCopyWithImpl;
@override @useResult
$Res call({
 int id, String pickupSpot, String arrivalSpot, DateTime startAt, DateTime endAt, int price, int numberOfSeats
});




}
/// @nodoc
class __$RideCopyWithImpl<$Res>
    implements _$RideCopyWith<$Res> {
  __$RideCopyWithImpl(this._self, this._then);

  final _Ride _self;
  final $Res Function(_Ride) _then;

/// Create a copy of Ride
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pickupSpot = null,Object? arrivalSpot = null,Object? startAt = null,Object? endAt = null,Object? price = null,Object? numberOfSeats = null,}) {
  return _then(_Ride(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pickupSpot: null == pickupSpot ? _self.pickupSpot : pickupSpot // ignore: cast_nullable_to_non_nullable
as String,arrivalSpot: null == arrivalSpot ? _self.arrivalSpot : arrivalSpot // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,numberOfSeats: null == numberOfSeats ? _self.numberOfSeats : numberOfSeats // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$RideSearchParams {

 String? get fromLocation; String? get toLocation; DateTime? get date; int? get seats;
/// Create a copy of RideSearchParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideSearchParamsCopyWith<RideSearchParams> get copyWith => _$RideSearchParamsCopyWithImpl<RideSearchParams>(this as RideSearchParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideSearchParams&&(identical(other.fromLocation, fromLocation) || other.fromLocation == fromLocation)&&(identical(other.toLocation, toLocation) || other.toLocation == toLocation)&&(identical(other.date, date) || other.date == date)&&(identical(other.seats, seats) || other.seats == seats));
}


@override
int get hashCode => Object.hash(runtimeType,fromLocation,toLocation,date,seats);

@override
String toString() {
  return 'RideSearchParams(fromLocation: $fromLocation, toLocation: $toLocation, date: $date, seats: $seats)';
}


}

/// @nodoc
abstract mixin class $RideSearchParamsCopyWith<$Res>  {
  factory $RideSearchParamsCopyWith(RideSearchParams value, $Res Function(RideSearchParams) _then) = _$RideSearchParamsCopyWithImpl;
@useResult
$Res call({
 String? fromLocation, String? toLocation, DateTime? date, int? seats
});




}
/// @nodoc
class _$RideSearchParamsCopyWithImpl<$Res>
    implements $RideSearchParamsCopyWith<$Res> {
  _$RideSearchParamsCopyWithImpl(this._self, this._then);

  final RideSearchParams _self;
  final $Res Function(RideSearchParams) _then;

/// Create a copy of RideSearchParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromLocation = freezed,Object? toLocation = freezed,Object? date = freezed,Object? seats = freezed,}) {
  return _then(_self.copyWith(
fromLocation: freezed == fromLocation ? _self.fromLocation : fromLocation // ignore: cast_nullable_to_non_nullable
as String?,toLocation: freezed == toLocation ? _self.toLocation : toLocation // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,seats: freezed == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RideSearchParams].
extension RideSearchParamsPatterns on RideSearchParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideSearchParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideSearchParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideSearchParams value)  $default,){
final _that = this;
switch (_that) {
case _RideSearchParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideSearchParams value)?  $default,){
final _that = this;
switch (_that) {
case _RideSearchParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fromLocation,  String? toLocation,  DateTime? date,  int? seats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideSearchParams() when $default != null:
return $default(_that.fromLocation,_that.toLocation,_that.date,_that.seats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fromLocation,  String? toLocation,  DateTime? date,  int? seats)  $default,) {final _that = this;
switch (_that) {
case _RideSearchParams():
return $default(_that.fromLocation,_that.toLocation,_that.date,_that.seats);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fromLocation,  String? toLocation,  DateTime? date,  int? seats)?  $default,) {final _that = this;
switch (_that) {
case _RideSearchParams() when $default != null:
return $default(_that.fromLocation,_that.toLocation,_that.date,_that.seats);case _:
  return null;

}
}

}

/// @nodoc


class _RideSearchParams implements RideSearchParams {
  const _RideSearchParams({this.fromLocation, this.toLocation, this.date, this.seats});
  

@override final  String? fromLocation;
@override final  String? toLocation;
@override final  DateTime? date;
@override final  int? seats;

/// Create a copy of RideSearchParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideSearchParamsCopyWith<_RideSearchParams> get copyWith => __$RideSearchParamsCopyWithImpl<_RideSearchParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideSearchParams&&(identical(other.fromLocation, fromLocation) || other.fromLocation == fromLocation)&&(identical(other.toLocation, toLocation) || other.toLocation == toLocation)&&(identical(other.date, date) || other.date == date)&&(identical(other.seats, seats) || other.seats == seats));
}


@override
int get hashCode => Object.hash(runtimeType,fromLocation,toLocation,date,seats);

@override
String toString() {
  return 'RideSearchParams(fromLocation: $fromLocation, toLocation: $toLocation, date: $date, seats: $seats)';
}


}

/// @nodoc
abstract mixin class _$RideSearchParamsCopyWith<$Res> implements $RideSearchParamsCopyWith<$Res> {
  factory _$RideSearchParamsCopyWith(_RideSearchParams value, $Res Function(_RideSearchParams) _then) = __$RideSearchParamsCopyWithImpl;
@override @useResult
$Res call({
 String? fromLocation, String? toLocation, DateTime? date, int? seats
});




}
/// @nodoc
class __$RideSearchParamsCopyWithImpl<$Res>
    implements _$RideSearchParamsCopyWith<$Res> {
  __$RideSearchParamsCopyWithImpl(this._self, this._then);

  final _RideSearchParams _self;
  final $Res Function(_RideSearchParams) _then;

/// Create a copy of RideSearchParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromLocation = freezed,Object? toLocation = freezed,Object? date = freezed,Object? seats = freezed,}) {
  return _then(_RideSearchParams(
fromLocation: freezed == fromLocation ? _self.fromLocation : fromLocation // ignore: cast_nullable_to_non_nullable
as String?,toLocation: freezed == toLocation ? _self.toLocation : toLocation // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,seats: freezed == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
