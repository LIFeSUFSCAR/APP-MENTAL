// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debug_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebugLevelAdapter extends TypeAdapter<DebugLevel> {
  @override
  final int typeId = 4;

  @override
  DebugLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DebugLevel.none;
      case 1:
        return DebugLevel.error;
      case 2:
        return DebugLevel.verbose;
      default:
        return DebugLevel.none;
    }
  }

  @override
  void write(BinaryWriter writer, DebugLevel obj) {
    switch (obj) {
      case DebugLevel.none:
        writer.writeByte(0);
        break;
      case DebugLevel.error:
        writer.writeByte(1);
        break;
      case DebugLevel.verbose:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebugLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
