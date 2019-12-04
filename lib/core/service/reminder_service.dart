import 'package:hive/hive.dart';
import 'package:never_forget/model/reminder.dart';

import '../utils.dart';

class ReminderService {
  Future<void> openReminderBox() {
    return Hive.openBox<Reminder>(REMINDER);
  }

  Box<Reminder> getReminderBox() {
    return Hive.box(REMINDER);
  }

  List<Reminder> getRemindersList() {
    final reminderBox = getReminderBox();
    return reminderBox.values.toList();
  }
}