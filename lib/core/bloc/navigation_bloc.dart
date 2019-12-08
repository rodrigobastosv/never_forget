import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/page/reminders_calendar_page.dart';
import 'package:never_forget/page/reminders_list/reminders_list_page.dart';
import 'package:never_forget/page/save_reminder/save_reminder_page.dart';
import 'package:never_forget/page/settings_page.dart';
import 'package:rxdart/rxdart.dart';

class NavigationBloc implements Bloc {
  final _navigationController = BehaviorSubject<Page>.seeded(Page.SaveReminder);
  Stream<Page> get navigationStream => _navigationController.stream;

  final _dataController = BehaviorSubject<dynamic>.seeded(null);
  Stream<dynamic> get dataStream => _dataController.stream;

  void navigateToPage(Page page) {
    _navigationController.add(page);
  }

  void navigateToPageByIndex(int index) {
    switch (index) {
      case 0:
        navigateToPage(Page.SaveReminder);
        break;
      case 1:
        navigateToPage(Page.RemindersList);
        break;
      case 2:
        navigateToPage(Page.RemindersCalendar);
        break;
      case 3:
        navigateToPage(Page.Settings);
        break;
      default:
        navigateToPage(Page.RemindersCalendar);
        break;
    }
  }

  String getPageName(Page page) {
    switch (page) {
      case Page.RemindersCalendar:
        return 'Calendário';
      case Page.RemindersList:
        return 'Lembretes';
      case Page.SaveReminder:
        return 'Salvar Lembrete';
      case Page.Settings:
        return 'Preferências';
    }
    return 'Calendário';
  }

  Widget getPageWidget(Page page) {
    switch (page) {
      case Page.RemindersCalendar:
        return RemindersCalendarPage();
      case Page.RemindersList:
        return RemindersListPage();
      case Page.SaveReminder:
        return SaveReminderPage();
      case Page.Settings:
        return SettingsPage();
    }
    return RemindersCalendarPage();
  }

  dynamic getData() {
    return _dataController.value;
  }

  void pushData(dynamic data) {
    _dataController.add(data);
  }

  void cleanData() {
    _dataController.add(null);
  }

  @override
  void dispose() {
    _navigationController.close();
    _dataController.close();
  }
}