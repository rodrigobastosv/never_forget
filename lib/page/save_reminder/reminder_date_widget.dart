import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:never_forget/core/date_utils.dart';

class ReminderDateWidget extends StatefulWidget {
  const ReminderDateWidget({this.onConfirm});

  final Function(DateTime) onConfirm;

  @override
  _ReminderDateWidgetState createState() => _ReminderDateWidgetState();
}

class _ReminderDateWidgetState extends State<ReminderDateWidget> {
  String pickedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
                minTime: DateUtils.getMinTime(),
                maxTime: DateUtils.getMaxTime(),
                onConfirm: (datePicked) {
                  widget.onConfirm(datePicked);
                  setState(() => pickedDate = DateUtils.formatLocale(datePicked));
                },
                currentTime: DateTime.now(),
                locale: LocaleType.pt,
              );
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                SizedBox(width: 8),
                Text(
                  'Data do Lembrete',
                ),
                SizedBox(width: 8),
                pickedDate != null ? Text(pickedDate) : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
