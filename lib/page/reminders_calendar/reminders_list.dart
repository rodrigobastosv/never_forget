import 'package:flutter/material.dart';
import 'package:never_forget/model/reminder.dart';

import 'reminder_tile.dart';

class RemindersList extends StatelessWidget {
  const RemindersList(this.reminders);

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    if (reminders.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (_, i) => ReminderTile(reminders[i]),
        separatorBuilder: (_, __) => Divider(),
        itemCount: reminders.length,
      );
    }
    return Center(
      child: Text('Nenhum lembrete para a data selecionada'),
    );
  }
}