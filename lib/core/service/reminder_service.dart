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

  List<Reminder> getRemindersList(String filter) {
    List<Reminder> remindersList = [];
    final reminderBox = getReminderBox();
    if (filter == '') {
      remindersList = reminderBox.values.toList();
    } else {
      remindersList = reminderBox.values.toList().where((reminder) {
        final title = reminder.title ?? '';
        final description = reminder.description ?? '';
        return title.contains(filter) || description.contains(filter);
      }).toList();
    }
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
