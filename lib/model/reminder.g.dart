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
      ..id = fields[0] as String
      ..title = fields[1] as String
      ..description = fields[2] as String
      ..date = fields[3] as DateTime
      ..assetImage = fields[4] as String
      ..repetitionType = fields[5] as RepetitionType
      ..notificationId = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.assetImage)
      ..writeByte(5)
      ..write(obj.repetitionType)
      ..writeByte(6)
      ..write(obj.notificationId);
  }
}
