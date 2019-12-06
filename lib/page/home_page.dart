import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/enum/page.dart';

import 'package:never_forget/page/reminders_list/reminders_list_page.dart';
import 'settings_page.dart';
import 'package:never_forget/page/save_reminder/save_reminder_page.dart';
import 'reminders_calendar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> boxFuture;

  final _reminderService = ReminderService();

  @override
  void initState() {
    boxFuture = _reminderService.openReminderBox();
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: boxFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<Page>(
                stream: BlocProvider.of<NavigationBloc>(context).navigationStream,
                initialData: Page.RemindersCalendar,
                builder: (_, snapshot) => _navigateToPage(snapshot.data)
              );
            }
            return Container();
          }
      ),
    );
  }

  Widget _navigateToPage(Page page) {
    switch (page) {
      case Page.RemindersCalendar:
        return RemindersCalendarPage();
      case Page.RemindersList:
        return RemindersListPage();
      case Page.SaveReminder:
        return SaveReminderPage();
      case Page.Settings:
        return SettingsPage();
      default:
        return null;
    }
  }
}
