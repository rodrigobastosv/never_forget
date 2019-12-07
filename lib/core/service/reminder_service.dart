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
    final now = DateTime.now();
    final reminderBox = getReminderBox();
    final remindersList = reminderBox.values.toList()
      .where((reminder) => reminder.date.isAfter(now)).toList();
    remindersList.sort((r1, r2) => r1.date.compareTo(r2.date));
    return remindersList;
  }

  Future<void> saveReminder(Reminder reminder) async {
    final reminders = getReminderBox();
    if (reminders.containsKey(reminder.key)) {
      reminders.delete(reminder.key);
    }
    await reminders.add(reminder);
  }
}