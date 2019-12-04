import 'package:flutter/material.dart';

class RemindersCalendarPage extends StatelessWidget {
  const RemindersCalendarPage({this.navigateTo});

  final Function(int) navigateTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('REMINDERS CALENDAR PAGE'),
      ),
    );
  }
}
