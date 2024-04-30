// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_parameters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SensorParametersAdapter extends TypeAdapter<_$SensorParametersImpl> {
  @override
  final int typeId = 0;

  @override
  _$SensorParametersImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SensorParametersImpl(
      url: fields[0] as String,
      sendDataInterval: fields[1] as int,
      captureDataThrottle: fields[2] as int,
      captureAccelerometer: fields[3] as bool,
      captureGyroscope: fields[4] as bool,
      captureLocation: fields[5] as bool,
      captureSleep: fields[6] as bool,
      captureScreenState: fields[7] as bool,
      showDebug: fields[8] as DebugLevel,
      healthDataCollectionInterval: fields[9] as int,
      fieldsParameters: fields[10] as FieldsParameters,
      email: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$SensorParametersImpl obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.sendDataInterval)
      ..writeByte(2)
      ..write(obj.captureDataThrottle)
      ..writeByte(3)
      ..write(obj.captureAccelerometer)
      ..writeByte(4)
      ..write(obj.captureGyroscope)
      ..writeByte(5)
      ..write(obj.captureLocation)
      ..writeByte(6)
      ..write(obj.captureSleep)
      ..writeByte(7)
      ..write(obj.captureScreenState)
      ..writeByte(8)
      ..write(obj.showDebug)
      ..writeByte(9)
      ..write(obj.healthDataCollectionInterval)
      ..writeByte(10)
      ..write(obj.fieldsParameters)
      ..writeByte(11)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorParametersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorParametersImpl _$$SensorParametersImplFromJson(
        Map<String, dynamic> json) =>
    _$SensorParametersImpl(
      url: json['url'] as String,
      sendDataInterval: json['sendDataInterval'] as int? ?? 5,
      captureDataThrottle: json['captureDataThrottle'] as int? ?? 100,
      captureAccelerometer: json['captureAccelerometer'] as bool? ?? true,
      captureGyroscope: json['captureGyroscope'] as bool? ?? true,
      captureLocation: json['captureLocation'] as bool? ?? true,
      captureSleep: json['captureSleep'] as bool? ?? true,
      captureScreenState: json['captureScreenState'] as bool? ?? true,
      showDebug: $enumDecodeNullable(_$DebugLevelEnumMap, json['showDebug']) ??
          DebugLevel.none,
      healthDataCollectionInterval:
          json['healthDataCollectionInterval'] as int? ?? 86400,
      fieldsParameters: json['fieldsParameters'] == null
          ? const FieldsParameters()
          : FieldsParameters.fromJson(
              json['fieldsParameters'] as Map<String, dynamic>),
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$$SensorParametersImplToJson(
        _$SensorParametersImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'sendDataInterval': instance.sendDataInterval,
      'captureDataThrottle': instance.captureDataThrottle,
      'captureAccelerometer': instance.captureAccelerometer,
      'captureGyroscope': instance.captureGyroscope,
      'captureLocation': instance.captureLocation,
      'captureSleep': instance.captureSleep,
      'captureScreenState': instance.captureScreenState,
      'showDebug': _$DebugLevelEnumMap[instance.showDebug]!,
      'healthDataCollectionInterval': instance.healthDataCollectionInterval,
      'fieldsParameters': instance.fieldsParameters,
      'email': instance.email,
    };

const _$DebugLevelEnumMap = {
  DebugLevel.none: 'none',
  DebugLevel.error: 'error',
  DebugLevel.verbose: 'verbose',
};
