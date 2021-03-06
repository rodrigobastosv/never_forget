import 'package:flutter/material.dart';
import 'package:never_forget/model/reminder.dart';

import 'reminder_tile.dart';

class RemindersList extends StatelessWidget {
  const RemindersList(this.reminders);

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(.8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (reminders.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, i) => ReminderTile(reminders[i]),
        separatorBuilder: (_, __) => Divider(height: 1),
        itemCount: reminders.length,
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Nenhum lembrete para a data selecionada.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
