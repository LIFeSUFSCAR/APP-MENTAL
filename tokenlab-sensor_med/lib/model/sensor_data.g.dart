// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SensorDataAdapter extends TypeAdapter<_$SensorDataImpl> {
  @override
  final int typeId = 1;

  @override
  _$SensorDataImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SensorDataImpl(
      type: fields[0] as SensorType,
      status: fields[1] as SendStatus,
      timestamp: fields[2] as DateTime,
      data: fields[3] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, _$SensorDataImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorDataImpl _$$SensorDataImplFromJson(Map<String, dynamic> json) =>
    _$SensorDataImpl(
      type: $enumDecode(_$SensorTypeEnumMap, json['type']),
      status: $enumDecode(_$SendStatusEnumMap, json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'],
    );

Map<String, dynamic> _$$SensorDataImplToJson(_$SensorDataImpl instance) =>
    <String, dynamic>{
      'type': _$SensorTypeEnumMap[instance.type]!,
      'status': _$SendStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
    };

const _$SensorTypeEnumMap = {
  SensorType.gyroscope: 'gyroscope',
  SensorType.accelerometer: 'accelerometer',
  SensorType.screenState: 'screenState',
  SensorType.sleep: 'sleep',
  SensorType.gps: 'gps',
};

const _$SendStatusEnumMap = {
  SendStatus.waiting: 'waiting',
  SendStatus.sent: 'sent',
};
