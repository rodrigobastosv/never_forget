import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/core/utils.dart';
import 'package:never_forget/model/reminder.dart';
import 'package:never_forget/ui/ui_constants.dart';

import 'add_image_container.dart';
import 'reminder_date_widget.dart';

class SaveReminderPage extends StatefulWidget {
  const SaveReminderPage({this.navigateTo});

  final Function(int) navigateTo;

  @override
  _SaveReminderPageState createState() => _SaveReminderPageState();
}

class _SaveReminderPageState extends State<SaveReminderPage> with GGValidators {
  final _reminderService = ReminderService();
  final _formKey = GlobalKey<FormState>();

  Reminder _reminder;

  @override
  void initState() {
    _reminder = Reminder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ReminderDateWidget(onConfirm: _onConfirmDate),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: <Widget>[
                    GGOutlinedTextFormField(
                      labelText: 'Título *',
                      textInputAction: TextInputAction.done,
                      onSaved: (title) => _reminder.title = title,
                      validator: emptyValidator,
                    ),
                    formVerticalSeparator,
                    GGOutlinedTextFormField(
                      labelText: 'Descrição *',
                      textInputAction: TextInputAction.done,
                      onSaved: (description) => _reminder.description = description,
                      validator: emptyValidator,
                      minLines: 3,
                      maxLines: 5,
                    ),
                    formVerticalSeparator,
                    formVerticalSeparator,
                    formVerticalSeparator,
                    AddImageContainer(onPickImage: _onPickImage),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final formState = _formKey.currentState;
          if (formState.validate()) {
            formState.save();
            final reminders = _reminderService.getReminderBox();
            await reminders.add(_reminder);
            widget.navigateTo(Pages.RemindersListPage.index);
          }
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }

  void _onConfirmDate(DateTime dateTime) {
    setState(() => _reminder.date = dateTime);
  }

  void _onPickImage(File image) {
    _reminder.assetImage = image.path;
  }
}
