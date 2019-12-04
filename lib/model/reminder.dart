import 'package:hive/hive.dart';
import 'package:never_forget/enum/repetition_type.dart';

part 'reminder.g.dart';

@HiveType()
class Reminder extends HiveObject {

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String assetImage;

  @HiveField(4)
  RepetitionType repetitionType;

  @HiveField(5)
  String notificationId;

  @override
  String toString() {
    return 'Reminder{title: $title, description: $description, date: $date, assetImage: $assetImage, repetitionType: $repetitionType, notificationId: $notificationId}';
  }
}