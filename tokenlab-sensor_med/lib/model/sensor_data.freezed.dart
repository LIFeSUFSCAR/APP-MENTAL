// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SensorData _$SensorDataFromJson(Map<String, dynamic> json) {
  return _SensorData.fromJson(json);
}

/// @nodoc
mixin _$SensorData {
  @HiveField(0)
  SensorType get type => throw _privateConstructorUsedError;
  @HiveField(1)
  SendStatus get status => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get timestamp => throw _privateConstructorUsedError;
  @HiveField(3)
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SensorDataCopyWith<SensorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorDataCopyWith<$Res> {
  factory $SensorDataCopyWith(
          SensorData value, $Res Function(SensorData) then) =
      _$SensorDataCopyWithImpl<$Res, SensorData>;
  @useResult
  $Res call(
      {@HiveField(0) SensorType type,
      @HiveField(1) SendStatus status,
      @HiveField(2) DateTime timestamp,
      @HiveField(3) dynamic data});
}

/// @nodoc
class _$SensorDataCopyWithImpl<$Res, $Val extends SensorData>
    implements $SensorDataCopyWith<$Res> {
  _$SensorDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? status = null,
    Object? timestamp = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SensorType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SensorDataImplCopyWith<$Res>
    implements $SensorDataCopyWith<$Res> {
  factory _$$SensorDataImplCopyWith(
          _$SensorDataImpl value, $Res Function(_$SensorDataImpl) then) =
      __$$SensorDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) SensorType type,
      @HiveField(1) SendStatus status,
      @HiveField(2) DateTime timestamp,
      @HiveField(3) dynamic data});
}

/// @nodoc
class __$$SensorDataImplCopyWithImpl<$Res>
    extends _$SensorDataCopyWithImpl<$Res, _$SensorDataImpl>
    implements _$$SensorDataImplCopyWith<$Res> {
  __$$SensorDataImplCopyWithImpl(
      _$SensorDataImpl _value, $Res Function(_$SensorDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? status = null,
    Object? timestamp = null,
    Object? data = freezed,
  }) {
    return _then(_$SensorDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SensorType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SendStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'SensorDataAdapter')
class _$SensorDataImpl implements _SensorData {
  const _$SensorDataImpl(
      {@HiveField(0) required this.type,
      @HiveField(1) required this.status,
      @HiveField(2) required this.timestamp,
      @HiveField(3) required this.data});

  factory _$SensorDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorDataImplFromJson(json);

  @override
  @HiveField(0)
  final SensorType type;
  @override
  @HiveField(1)
  final SendStatus status;
  @override
  @HiveField(2)
  final DateTime timestamp;
  @override
  @HiveField(3)
  final dynamic data;

  @override
  String toString() {
    return 'SensorData(type: $type, status: $status, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, status, timestamp,
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorDataImplCopyWith<_$SensorDataImpl> get copyWith =>
      __$$SensorDataImplCopyWithImpl<_$SensorDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorDataImplToJson(
      this,
    );
  }
}

abstract class _SensorData implements SensorData {
  const factory _SensorData(
      {@HiveField(0) required final SensorType type,
      @HiveField(1) required final SendStatus status,
      @HiveField(2) required final DateTime timestamp,
      @HiveField(3) required final dynamic data}) = _$SensorDataImpl;

  factory _SensorData.fromJson(Map<String, dynamic> json) =
      _$SensorDataImpl.fromJson;

  @override
  @HiveField(0)
  SensorType get type;
  @override
  @HiveField(1)
  SendStatus get status;
  @override
  @HiveField(2)
  DateTime get timestamp;
  @override
  @HiveField(3)
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$SensorDataImplCopyWith<_$SensorDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
