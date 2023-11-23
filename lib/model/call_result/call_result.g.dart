// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallResultAdapter extends TypeAdapter<CallResult> {
  @override
  final int typeId = 3;

  @override
  CallResult read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CallResult.agreement;
      case 1:
        return CallResult.noAnswer;
      case 2:
        return CallResult.noConnection;
      case 3:
        return CallResult.wrongPrice;
      case 4:
        return CallResult.notActual;
      default:
        return CallResult.agreement;
    }
  }

  @override
  void write(BinaryWriter writer, CallResult obj) {
    switch (obj) {
      case CallResult.agreement:
        writer.writeByte(0);
        break;
      case CallResult.noAnswer:
        writer.writeByte(1);
        break;
      case CallResult.noConnection:
        writer.writeByte(2);
        break;
      case CallResult.wrongPrice:
        writer.writeByte(3);
        break;
      case CallResult.notActual:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
