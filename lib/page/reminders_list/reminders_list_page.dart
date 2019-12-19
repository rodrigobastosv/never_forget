import 'package:flutter/material.dart';
import 'package:never_forget/core/locator.dart';

import 'reminder_tile.dart';

class RemindersListPage extends StatelessWidget {
  final _reminderService = getReminderService();

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderService.getRemindersList();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: reminders.length,
      itemBuilder: (_, i) => ReminderTile(reminders[i]),
      separatorBuilder: (_, i) => Divider(),
    );
  }
}
