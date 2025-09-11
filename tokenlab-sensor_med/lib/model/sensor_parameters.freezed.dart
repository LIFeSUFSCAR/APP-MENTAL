// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SensorParameters _$SensorParametersFromJson(Map<String, dynamic> json) {
  return _SensorParameters.fromJson(json);
}

/// @nodoc
mixin _$SensorParameters {
  @HiveField(0)
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  int get sendDataInterval => throw _privateConstructorUsedError;
  @HiveField(2)
  int get captureDataThrottle => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get captureAccelerometer => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get captureGyroscope => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get captureLocation => throw _privateConstructorUsedError;
  @HiveField(6)
  bool get captureSleep => throw _privateConstructorUsedError;
  @HiveField(7)
  bool get captureScreenState => throw _privateConstructorUsedError;
  @HiveField(8)
  DebugLevel get showDebug => throw _privateConstructorUsedError;
  @HiveField(9)
  int get healthDataCollectionInterval => throw _privateConstructorUsedError;
  @HiveField(10)
  FieldsParameters get fieldsParameters => throw _privateConstructorUsedError;
  @HiveField(11)
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SensorParametersCopyWith<SensorParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorParametersCopyWith<$Res> {
  factory $SensorParametersCopyWith(
          SensorParameters value, $Res Function(SensorParameters) then) =
      _$SensorParametersCopyWithImpl<$Res, SensorParameters>;
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) int sendDataInterval,
      @HiveField(2) int captureDataThrottle,
      @HiveField(3) bool captureAccelerometer,
      @HiveField(4) bool captureGyroscope,
      @HiveField(5) bool captureLocation,
      @HiveField(6) bool captureSleep,
      @HiveField(7) bool captureScreenState,
      @HiveField(8) DebugLevel showDebug,
      @HiveField(9) int healthDataCollectionInterval,
      @HiveField(10) FieldsParameters fieldsParameters,
      @HiveField(11) String email});

  $FieldsParametersCopyWith<$Res> get fieldsParameters;
}

/// @nodoc
class _$SensorParametersCopyWithImpl<$Res, $Val extends SensorParameters>
    implements $SensorParametersCopyWith<$Res> {
  _$SensorParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? sendDataInterval = null,
    Object? captureDataThrottle = null,
    Object? captureAccelerometer = null,
    Object? captureGyroscope = null,
    Object? captureLocation = null,
    Object? captureSleep = null,
    Object? captureScreenState = null,
    Object? showDebug = null,
    Object? healthDataCollectionInterval = null,
    Object? fieldsParameters = null,
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      sendDataInterval: null == sendDataInterval
          ? _value.sendDataInterval
          : sendDataInterval // ignore: cast_nullable_to_non_nullable
              as int,
      captureDataThrottle: null == captureDataThrottle
          ? _value.captureDataThrottle
          : captureDataThrottle // ignore: cast_nullable_to_non_nullable
              as int,
      captureAccelerometer: null == captureAccelerometer
          ? _value.captureAccelerometer
          : captureAccelerometer // ignore: cast_nullable_to_non_nullable
              as bool,
      captureGyroscope: null == captureGyroscope
          ? _value.captureGyroscope
          : captureGyroscope // ignore: cast_nullable_to_non_nullable
              as bool,
      captureLocation: null == captureLocation
          ? _value.captureLocation
          : captureLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      captureSleep: null == captureSleep
          ? _value.captureSleep
          : captureSleep // ignore: cast_nullable_to_non_nullable
              as bool,
      captureScreenState: null == captureScreenState
          ? _value.captureScreenState
          : captureScreenState // ignore: cast_nullable_to_non_nullable
              as bool,
      showDebug: null == showDebug
          ? _value.showDebug
          : showDebug // ignore: cast_nullable_to_non_nullable
              as DebugLevel,
      healthDataCollectionInterval: null == healthDataCollectionInterval
          ? _value.healthDataCollectionInterval
          : healthDataCollectionInterval // ignore: cast_nullable_to_non_nullable
              as int,
      fieldsParameters: null == fieldsParameters
          ? _value.fieldsParameters
          : fieldsParameters // ignore: cast_nullable_to_non_nullable
              as FieldsParameters,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldsParametersCopyWith<$Res> get fieldsParameters {
    return $FieldsParametersCopyWith<$Res>(_value.fieldsParameters, (value) {
      return _then(_value.copyWith(fieldsParameters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SensorParametersImplCopyWith<$Res>
    implements $SensorParametersCopyWith<$Res> {
  factory _$$SensorParametersImplCopyWith(_$SensorParametersImpl value,
          $Res Function(_$SensorParametersImpl) then) =
      __$$SensorParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) int sendDataInterval,
      @HiveField(2) int captureDataThrottle,
      @HiveField(3) bool captureAccelerometer,
      @HiveField(4) bool captureGyroscope,
      @HiveField(5) bool captureLocation,
      @HiveField(6) bool captureSleep,
      @HiveField(7) bool captureScreenState,
      @HiveField(8) DebugLevel showDebug,
      @HiveField(9) int healthDataCollectionInterval,
      @HiveField(10) FieldsParameters fieldsParameters,
      @HiveField(11) String email});

  @override
  $FieldsParametersCopyWith<$Res> get fieldsParameters;
}

/// @nodoc
class __$$SensorParametersImplCopyWithImpl<$Res>
    extends _$SensorParametersCopyWithImpl<$Res, _$SensorParametersImpl>
    implements _$$SensorParametersImplCopyWith<$Res> {
  __$$SensorParametersImplCopyWithImpl(_$SensorParametersImpl _value,
      $Res Function(_$SensorParametersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? sendDataInterval = null,
    Object? captureDataThrottle = null,
    Object? captureAccelerometer = null,
    Object? captureGyroscope = null,
    Object? captureLocation = null,
    Object? captureSleep = null,
    Object? captureScreenState = null,
    Object? showDebug = null,
    Object? healthDataCollectionInterval = null,
    Object? fieldsParameters = null,
    Object? email = null,
  }) {
    return _then(_$SensorParametersImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      sendDataInterval: null == sendDataInterval
          ? _value.sendDataInterval
          : sendDataInterval // ignore: cast_nullable_to_non_nullable
              as int,
      captureDataThrottle: null == captureDataThrottle
          ? _value.captureDataThrottle
          : captureDataThrottle // ignore: cast_nullable_to_non_nullable
              as int,
      captureAccelerometer: null == captureAccelerometer
          ? _value.captureAccelerometer
          : captureAccelerometer // ignore: cast_nullable_to_non_nullable
              as bool,
      captureGyroscope: null == captureGyroscope
          ? _value.captureGyroscope
          : captureGyroscope // ignore: cast_nullable_to_non_nullable
              as bool,
      captureLocation: null == captureLocation
          ? _value.captureLocation
          : captureLocation // ignore: cast_nullable_to_non_nullable
              as bool,
      captureSleep: null == captureSleep
          ? _value.captureSleep
          : captureSleep // ignore: cast_nullable_to_non_nullable
              as bool,
      captureScreenState: null == captureScreenState
          ? _value.captureScreenState
          : captureScreenState // ignore: cast_nullable_to_non_nullable
              as bool,
      showDebug: null == showDebug
          ? _value.showDebug
          : showDebug // ignore: cast_nullable_to_non_nullable
              as DebugLevel,
      healthDataCollectionInterval: null == healthDataCollectionInterval
          ? _value.healthDataCollectionInterval
          : healthDataCollectionInterval // ignore: cast_nullable_to_non_nullable
              as int,
      fieldsParameters: null == fieldsParameters
          ? _value.fieldsParameters
          : fieldsParameters // ignore: cast_nullable_to_non_nullable
              as FieldsParameters,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 0, adapterName: 'SensorParametersAdapter')
class _$SensorParametersImpl implements _SensorParameters {
  const _$SensorParametersImpl(
      {@HiveField(0) required this.url,
      @HiveField(1) this.sendDataInterval = 5,
      @HiveField(2) this.captureDataThrottle = 100,
      @HiveField(3) this.captureAccelerometer = true,
      @HiveField(4) this.captureGyroscope = true,
      @HiveField(5) this.captureLocation = true,
      @HiveField(6) this.captureSleep = true,
      @HiveField(7) this.captureScreenState = true,
      @HiveField(8) this.showDebug = DebugLevel.none,
      @HiveField(9) this.healthDataCollectionInterval = 86400,
      @HiveField(10) this.fieldsParameters = const FieldsParameters(),
      @HiveField(11) this.email = ''});

  factory _$SensorParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorParametersImplFromJson(json);

  @override
  @HiveField(0)
  final String url;
  @override
  @JsonKey()
  @HiveField(1)
  final int sendDataInterval;
  @override
  @JsonKey()
  @HiveField(2)
  final int captureDataThrottle;
  @override
  @JsonKey()
  @HiveField(3)
  final bool captureAccelerometer;
  @override
  @JsonKey()
  @HiveField(4)
  final bool captureGyroscope;
  @override
  @JsonKey()
  @HiveField(5)
  final bool captureLocation;
  @override
  @JsonKey()
  @HiveField(6)
  final bool captureSleep;
  @override
  @JsonKey()
  @HiveField(7)
  final bool captureScreenState;
  @override
  @JsonKey()
  @HiveField(8)
  final DebugLevel showDebug;
  @override
  @JsonKey()
  @HiveField(9)
  final int healthDataCollectionInterval;
  @override
  @JsonKey()
  @HiveField(10)
  final FieldsParameters fieldsParameters;
  @override
  @JsonKey()
  @HiveField(11)
  final String email;

  @override
  String toString() {
    return 'SensorParameters(url: $url, sendDataInterval: $sendDataInterval, captureDataThrottle: $captureDataThrottle, captureAccelerometer: $captureAccelerometer, captureGyroscope: $captureGyroscope, captureLocation: $captureLocation, captureSleep: $captureSleep, captureScreenState: $captureScreenState, showDebug: $showDebug, healthDataCollectionInterval: $healthDataCollectionInterval, fieldsParameters: $fieldsParameters, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorParametersImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sendDataInterval, sendDataInterval) ||
                other.sendDataInterval == sendDataInterval) &&
            (identical(other.captureDataThrottle, captureDataThrottle) ||
                other.captureDataThrottle == captureDataThrottle) &&
            (identical(other.captureAccelerometer, captureAccelerometer) ||
                other.captureAccelerometer == captureAccelerometer) &&
            (identical(other.captureGyroscope, captureGyroscope) ||
                other.captureGyroscope == captureGyroscope) &&
            (identical(other.captureLocation, captureLocation) ||
                other.captureLocation == captureLocation) &&
            (identical(other.captureSleep, captureSleep) ||
                other.captureSleep == captureSleep) &&
            (identical(other.captureScreenState, captureScreenState) ||
                other.captureScreenState == captureScreenState) &&
            (identical(other.showDebug, showDebug) ||
                other.showDebug == showDebug) &&
            (identical(other.healthDataCollectionInterval,
                    healthDataCollectionInterval) ||
                other.healthDataCollectionInterval ==
                    healthDataCollectionInterval) &&
            (identical(other.fieldsParameters, fieldsParameters) ||
                other.fieldsParameters == fieldsParameters) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      url,
      sendDataInterval,
      captureDataThrottle,
      captureAccelerometer,
      captureGyroscope,
      captureLocation,
      captureSleep,
      captureScreenState,
      showDebug,
      healthDataCollectionInterval,
      fieldsParameters,
      email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorParametersImplCopyWith<_$SensorParametersImpl> get copyWith =>
      __$$SensorParametersImplCopyWithImpl<_$SensorParametersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorParametersImplToJson(
      this,
    );
  }
}

abstract class _SensorParameters implements SensorParameters {
  const factory _SensorParameters(
      {@HiveField(0) required final String url,
      @HiveField(1) final int sendDataInterval,
      @HiveField(2) final int captureDataThrottle,
      @HiveField(3) final bool captureAccelerometer,
      @HiveField(4) final bool captureGyroscope,
      @HiveField(5) final bool captureLocation,
      @HiveField(6) final bool captureSleep,
      @HiveField(7) final bool captureScreenState,
      @HiveField(8) final DebugLevel showDebug,
      @HiveField(9) final int healthDataCollectionInterval,
      @HiveField(10) final FieldsParameters fieldsParameters,
      @HiveField(11) final String email}) = _$SensorParametersImpl;

  factory _SensorParameters.fromJson(Map<String, dynamic> json) =
      _$SensorParametersImpl.fromJson;

  @override
  @HiveField(0)
  String get url;
  @override
  @HiveField(1)
  int get sendDataInterval;
  @override
  @HiveField(2)
  int get captureDataThrottle;
  @override
  @HiveField(3)
  bool get captureAccelerometer;
  @override
  @HiveField(4)
  bool get captureGyroscope;
  @override
  @HiveField(5)
  bool get captureLocation;
  @override
  @HiveField(6)
  bool get captureSleep;
  @override
  @HiveField(7)
  bool get captureScreenState;
  @override
  @HiveField(8)
  DebugLevel get showDebug;
  @override
  @HiveField(9)
  int get healthDataCollectionInterval;
  @override
  @HiveField(10)
  FieldsParameters get fieldsParameters;
  @override
  @HiveField(11)
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$SensorParametersImplCopyWith<_$SensorParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
