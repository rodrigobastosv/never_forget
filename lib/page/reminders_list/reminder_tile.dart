import 'package:flutter/material.dart';
import 'package:never_forget/model/reminder.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile(this.reminder);

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(reminder.title),
      subtitle: Text(reminder.description),
    );
  }
}
