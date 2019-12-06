// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  Reminder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminder()
      ..title = fields[0] as String
      ..description = fields[1] as String
      ..date = fields[2] as DateTime
      ..assetImage = fields[3] as String
      ..repetitionType = fields[4] as RepetitionType
      ..notificationId = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.assetImage)
      ..writeByte(4)
      ..write(obj.repetitionType)
      ..writeByte(5)
      ..write(obj.notificationId);
  }
}
