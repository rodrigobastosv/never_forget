import 'package:flutter/material.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/model/reminder.dart';
import 'package:never_forget/widget/nf_scaffold.dart';

import 'reminder_tile.dart';

class RemindersListPage extends StatefulWidget {
  RemindersListPage(this.page);
  final Page page;

  @override
  _RemindersListPageState createState() => _RemindersListPageState();
}

class _RemindersListPageState extends State<RemindersListPage> {
  final _reminderService = getReminderService();
  List<Reminder> reminders;
  String filter;

  @override
  void initState() {
    reminders = _reminderService.getRemindersList('');
    filter = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NFScaffold(
      selectedIndex: widget.page.index,
      body: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Pesquisar',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  reminders = _reminderService.getRemindersList(value);
                });
              },
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: reminders.length,
              itemBuilder: (_, i) => ReminderTile(reminders[i]),
              separatorBuilder: (_, i) => Divider(height: 1),
            ),
          ],
        ),
      ),
    );
  }
}
