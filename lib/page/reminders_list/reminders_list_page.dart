import 'package:flutter/material.dart';
import 'package:never_forget/core/service/reminder_service.dart';

import 'reminder_tile.dart';

class RemindersListPage extends StatelessWidget {
  RemindersListPage({this.navigateTo});

  final Function(int) navigateTo;
  final _reminderService = ReminderService();

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderService.getRemindersList();

    return ListView.separated(
      itemCount: reminders.length,
      itemBuilder: (_, i) => ReminderTile(reminders[i]),
      separatorBuilder: (_, i) => Divider(),
    );
  }
}
