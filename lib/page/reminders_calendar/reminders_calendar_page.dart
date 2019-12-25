import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/model/reminder.dart';
import 'package:never_forget/widget/nf_scaffold.dart';
import 'package:table_calendar/table_calendar.dart';

import 'reminders_list.dart';

class RemindersCalendarPage extends StatefulWidget {
  const RemindersCalendarPage(this.page);
  final Page page;

  @override
  _RemindersCalendarPageState createState() => _RemindersCalendarPageState();
}

class _RemindersCalendarPageState extends State<RemindersCalendarPage> {
  final _reminderService = getReminderService();
  final dateFormat = DateFormat('dd/MM/yyyy');

  List<Reminder> _remindersOfTheSelectedDay;
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    _remindersOfTheSelectedDay = _getRemindersOfDate(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NFScaffold(
      selectedIndex: widget.page.index,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: TableCalendar(
              calendarController: _calendarController,
              locale: 'pt_BR',
              events: _buildLessonsMap(),
              availableCalendarFormats: const {
                CalendarFormat.week: 'Semana',
                CalendarFormat.month: 'Mês',
              },
              headerStyle: HeaderStyle(
                headerPadding: null,
                formatButtonTextStyle: TextStyle(color: Colors.grey[600]),
                formatButtonDecoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                titleTextBuilder: (DateTime date, dynamic locale) =>
                    DateFormat.yMMM(locale).format(date),
              ),
              builders: CalendarBuilders(
                dayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.grey[400],
                        ),
                        BoxShadow(
                          offset: const Offset(0, -0.1),
                          color: Colors.grey[300],
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(fontSize: 14),
                      ),
                    ),
                  );
                },
                outsideDayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(
                          fontSize: 14,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                },
                outsideWeekendDayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(
                          fontSize: 14,
                          color: Colors.red[100],
                        ),
                      ),
                    ),
                  );
                },
                todayDayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: (date.weekday == 6 || date.weekday == 7)
                              ? Colors.red[100]
                              : Colors.grey[400],
                        ),
                        BoxShadow(
                          offset: const Offset(0, -0.1),
                          color: (date.weekday == 6 || date.weekday == 7)
                              ? Colors.red[50]
                              : Colors.grey[300],
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: (date.weekday == 6 || date.weekday == 7)
                            ? TextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[300])
                            : TextStyle().copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ),
                  );
                },
                weekendDayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          offset: const Offset(0, 1),
                          color: Colors.red[100],
                        ),
                        BoxShadow(
                          offset: const Offset(0, -0.1),
                          color: Colors.red[50],
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle().copyWith(
                          fontSize: 14.0,
                          color: Colors.red[300],
                        ),
                      ),
                    ),
                  );
                },
                selectedDayBuilder: (context, date, list) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.amber[600],
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: (date.weekday == 6 || date.weekday == 7) &&
                                _calendarController.isToday(date)
                            ? TextStyle().copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[300])
                            : (date.weekday == 6 || date.weekday == 7)
                                ? TextStyle().copyWith(
                                    fontSize: 14.0, color: Colors.red[300])
                                : _calendarController.isToday(date)
                                    ? TextStyle().copyWith(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      )
                                    : TextStyle().copyWith(fontSize: 14.0),
                      ),
                    ),
                  );
                },
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(
                      Center(
                        child: _buildEventsMarker(date, events),
                      ),
                    );
                  }

                  return children;
                },
              ),
              onDaySelected: (date, _) => _onDaySelected(date, _),
            ),
          ),
          Flexible(
            flex: 1,
            child: RemindersList(
              _remindersOfTheSelectedDay,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: _calendarController.isSelected(date)
            ? Border.all(width: 2, color: Colors.amber[600])
            : null,
        borderRadius: BorderRadius.circular(50),
        boxShadow: _calendarController.isSelected(date)
            ? null
            : <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.orange[300],
                ),
                BoxShadow(
                  offset: const Offset(0, -0.1),
                  color: Colors.orange[200],
                )
              ],
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: (_calendarController.isToday(date) ||
                      _calendarController.isSelected(date)) &&
                  (date.weekday == 6 || date.weekday == 7)
              ? TextStyle().copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[300])
              : TextStyle().copyWith(fontSize: 14.0),
        ),
      ),
    );
  }

  void _onDaySelected(DateTime date, List<dynamic> _) {
    setState(() {
      _remindersOfTheSelectedDay = _getRemindersOfDate(date);
    });
  }

  List<Reminder> _getRemindersOfDate(DateTime date) {
    final reminders = _reminderService.getRemindersList();
    return reminders
        .where((reminder) => isSameDay(reminder.date, date))
        .toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    final day1 = date1.day;
    final month1 = date1.month;
    final year1 = date1.year;

    final day2 = date2.day;
    final month2 = date2.month;
    final year2 = date2.year;

    return (day1 == day2) && (month1 == month2) && (year1 == year2);
  }

  Map<DateTime, List> _buildLessonsMap() {
    final reminders = _reminderService.getRemindersList();

    final Map<DateTime, List> remindersMap = {};
    for (Reminder reminder in reminders) {
      remindersMap.putIfAbsent(reminder.date, () => <dynamic>['']);
    }
    return remindersMap;
  }
}
