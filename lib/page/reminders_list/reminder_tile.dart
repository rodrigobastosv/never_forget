import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/core/bloc/menu_bloc.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/date_utils.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/model/menu.dart';
import 'package:never_forget/model/reminder.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile(this.reminder);

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    final menuBloc = BlocProvider.of<MenuBloc>(context);
    return ListTile(
      title: Text(reminder.title),
      subtitle: Text(DateUtils.formatLocale(reminder.date)),
      onTap: () {
        menuBloc.pickMenu(Menu()..title = 'Salvar Lembrete');
        navigationBloc.pushData(reminder);
        navigationBloc.navigateToPage(Page.SaveReminder);
      },
    );
  }
}
