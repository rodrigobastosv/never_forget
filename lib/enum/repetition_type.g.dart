// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repetition_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepetitionTypeAdapter extends TypeAdapter<RepetitionType> {
  @override
  RepetitionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RepetitionType.onetimeOnly;
      case 1:
        return RepetitionType.daily;
      case 2:
        return RepetitionType.monthly;
      case 3:
        return RepetitionType.yearly;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RepetitionType obj) {
    switch (obj) {
      case RepetitionType.onetimeOnly:
        writer.writeByte(0);
        break;
      case RepetitionType.daily:
        writer.writeByte(1);
        break;
      case RepetitionType.monthly:
        writer.writeByte(2);
        break;
      case RepetitionType.yearly:
        writer.writeByte(3);
        break;
    }
  }
}
