// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SensorTypeAdapter extends TypeAdapter<SensorType> {
  @override
  final int typeId = 3;

  @override
  SensorType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SensorType.gyroscope;
      case 1:
        return SensorType.accelerometer;
      case 2:
        return SensorType.screenState;
      case 3:
        return SensorType.sleep;
      case 4:
        return SensorType.gps;
      default:
        return SensorType.gyroscope;
    }
  }

  @override
  void write(BinaryWriter writer, SensorType obj) {
    switch (obj) {
      case SensorType.gyroscope:
        writer.writeByte(0);
        break;
      case SensorType.accelerometer:
        writer.writeByte(1);
        break;
      case SensorType.screenState:
        writer.writeByte(2);
        break;
      case SensorType.sleep:
        writer.writeByte(3);
        break;
      case SensorType.gps:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SensorTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
