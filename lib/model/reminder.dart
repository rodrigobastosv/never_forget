import 'package:hive/hive.dart';
import 'package:never_forget/enum/repetition_type.dart';

part 'reminder.g.dart';

@HiveType()
class Reminder extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String assetImage;

  @HiveField(5)
  RepetitionType repetitionType;

  @HiveField(6)
  int notificationId;

  @override
  String toString() {
    return 'Reminder{id: $id, title: $title, description: $description, date: $date, assetImage: $assetImage, repetitionType: $repetitionType, notificationId: $notificationId}';
  }
}