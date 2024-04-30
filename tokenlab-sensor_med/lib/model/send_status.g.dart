// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SendStatusAdapter extends TypeAdapter<SendStatus> {
  @override
  final int typeId = 2;

  @override
  SendStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SendStatus.waiting;
      case 1:
        return SendStatus.sent;
      default:
        return SendStatus.waiting;
    }
  }

  @override
  void write(BinaryWriter writer, SendStatus obj) {
    switch (obj) {
      case SendStatus.waiting:
        writer.writeByte(0);
        break;
      case SendStatus.sent:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SendStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
