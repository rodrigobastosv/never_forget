import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:never_forget/core/date_utils.dart';

class ReminderDateWidget extends StatefulWidget {
  const ReminderDateWidget(this.initialDate, {this.onConfirm});

  final DateTime initialDate;
  final Function(DateTime) onConfirm;

  @override
  _ReminderDateWidgetState createState() => _ReminderDateWidgetState();
}

class _ReminderDateWidgetState extends State<ReminderDateWidget> {
  String pickedDate;

  @override
  void initState() {
    pickedDate = widget.initialDate != null
        ? DateUtils.formatLocale(widget.initialDate)
        : '';
    super.initState();
  }

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
                  setState(() {
                    pickedDate = DateUtils.formatLocale(datePicked);
                  });
                },
                currentTime: widget.initialDate != null
                    ? widget.initialDate
                    : DateTime.now(),
                locale: LocaleType.pt,
              );
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                SizedBox(width: 8),
                Text(
                  pickedDate.isNotEmpty ? pickedDate : 'Data do Lembrete *',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
