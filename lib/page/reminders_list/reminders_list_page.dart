import 'package:flutter/material.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/widget/nf_scaffold.dart';

import 'reminder_tile.dart';

class RemindersListPage extends StatelessWidget {
  RemindersListPage(this.page);
  final Page page;
  final _reminderService = getReminderService();

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderService.getRemindersList();
    return NFScaffold(
      selectedIndex: page.index,
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: reminders.length,
        itemBuilder: (_, i) => ReminderTile(reminders[i]),
        separatorBuilder: (_, i) => Divider(),
      ),
    );
  }
}
