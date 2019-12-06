import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/enum/page.dart';

import 'package:never_forget/page/reminders_list/reminders_list_page.dart';
import 'settings_page.dart';
import 'widgets/nf_app_bar.dart';
import 'widgets/nf_bottom_navigation_bar.dart';
import 'package:never_forget/page/save_reminder/save_reminder_page.dart';
import 'reminders_calendar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;
  Future<void> boxFuture;

  Page get _currentPage => _getCurrentPage(_selectedIndex);
  final _reminderService = ReminderService();

  @override
  void initState() {
    _selectedIndex = 0;
    boxFuture = _reminderService.openReminderBox();
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NFAppBar.build(context),
      body: FutureBuilder(
        future: boxFuture,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _getPage(_selectedIndex);
            }
            return Container();
          }
      ),
      bottomNavigationBar: NFBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onChangedItem: _navigateTo,
      ),
      floatingActionButton: _currentPage != Page.SaveReminder ? FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _navigateTo(2),
      ) : null,
    );
  }

  void _navigateTo(int index) async {
    setState(() => _selectedIndex = index);
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return RemindersCalendarPage(navigateTo: _navigateTo);
      case 1:
        return RemindersListPage(navigateTo: _navigateTo);
      case 2:
        return SaveReminderPage(navigateTo: _navigateTo);
      case 3:
        return SettingsPage(navigateTo: _navigateTo);
      default:
        return null;
    }
  }

  Page _getCurrentPage(int index) {
    switch (index) {
      case 0:
        return Page.RemindersCalendar;
      case 1:
        return Page.RemindersList;
      case 2:
        return Page.SaveReminder;
      case 3:
        return Page.Settings;
      default:
        return null;
    }
  }
}
