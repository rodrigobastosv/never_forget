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
    return FlatButton(
      padding: const EdgeInsets.all(0),
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
          currentTime:
              widget.initialDate != null ? widget.initialDate : DateTime.now(),
          locale: LocaleType.pt,
        );
      },
      child: Container(
        width: 165,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 8,
              color: Colors.grey[300],
              offset: Offset(0, 0.4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (pickedDate.isNotEmpty)
              Text(
                'Data do Lembrete *',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
            Padding(
              padding: pickedDate.isNotEmpty
                  ? EdgeInsets.only(top: 2)
                  : EdgeInsets.symmetric(vertical: 8),
              child: Text(
                pickedDate.isNotEmpty ? pickedDate : 'Data do Lembrete *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color:
                      pickedDate.isNotEmpty ? Colors.black : Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
