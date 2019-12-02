import 'package:flutter/material.dart';

import 'reminders_list_page.dart';
import 'settings_page.dart';
import 'widgets/nf_app_bar.dart';
import 'widgets/nf_bottom_navigation_bar.dart';
import 'save_reminder_page.dart';
import 'reminders_calendar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NFAppBar.build(context),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: NFBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onChangedItem: _onChangeNavigatorItem,
      ),
    );
  }

  void _onChangeNavigatorItem(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return RemindersCalendarPage();
      case 1:
        return RemindersListPage();
      case 2:
        return SaveReminderPage();
      case 3:
        return SettingsPage();
      default:
        return null;
    }
  }
}
