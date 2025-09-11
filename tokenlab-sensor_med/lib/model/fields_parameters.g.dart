// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fields_parameters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FieldsParametersAdapter extends TypeAdapter<_$FieldsParametersImpl> {
  @override
  final int typeId = 5;

  @override
  _$FieldsParametersImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$FieldsParametersImpl(
      sentAtField: fields[0] as String,
      sensorsField: fields[1] as String,
      gyroscopeDataField: fields[2] as String,
      accelerometerDataField: fields[3] as String,
      locationDataField: fields[4] as String,
      sleepDataField: fields[5] as String,
      screenStateDataField: fields[6] as String,
      collectedAtField: fields[7] as String,
      sensorDataField: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$FieldsParametersImpl obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.sentAtField)
      ..writeByte(1)
      ..write(obj.sensorsField)
      ..writeByte(2)
      ..write(obj.gyroscopeDataField)
      ..writeByte(3)
      ..write(obj.accelerometerDataField)
      ..writeByte(4)
      ..write(obj.locationDataField)
      ..writeByte(5)
      ..write(obj.sleepDataField)
      ..writeByte(6)
      ..write(obj.screenStateDataField)
      ..writeByte(7)
      ..write(obj.collectedAtField)
      ..writeByte(8)
      ..write(obj.sensorDataField);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldsParametersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FieldsParametersImpl _$$FieldsParametersImplFromJson(
        Map<String, dynamic> json) =>
    _$FieldsParametersImpl(
      sentAtField: json['sentAtField'] as String? ?? 'sentAt',
      sensorsField: json['sensorsField'] as String? ?? 'sensors',
      gyroscopeDataField:
          json['gyroscopeDataField'] as String? ?? 'gyroscopeData',
      accelerometerDataField:
          json['accelerometerDataField'] as String? ?? 'accelerometerData',
      locationDataField: json['locationDataField'] as String? ?? 'locationData',
      sleepDataField: json['sleepDataField'] as String? ?? 'sleepData',
      screenStateDataField:
          json['screenStateDataField'] as String? ?? 'screenStateData',
      collectedAtField: json['collectedAtField'] as String? ?? 'collectedAt',
      sensorDataField: json['sensorDataField'] as String? ?? 'data',
    );

Map<String, dynamic> _$$FieldsParametersImplToJson(
        _$FieldsParametersImpl instance) =>
    <String, dynamic>{
      'sentAtField': instance.sentAtField,
      'sensorsField': instance.sensorsField,
      'gyroscopeDataField': instance.gyroscopeDataField,
      'accelerometerDataField': instance.accelerometerDataField,
      'locationDataField': instance.locationDataField,
      'sleepDataField': instance.sleepDataField,
      'screenStateDataField': instance.screenStateDataField,
      'collectedAtField': instance.collectedAtField,
      'sensorDataField': instance.sensorDataField,
    };
