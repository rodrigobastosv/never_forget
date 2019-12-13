import 'dart:io';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/service/notification_service.dart';

import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/enum/repetition_type.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:never_forget/model/reminder.dart';
import 'package:never_forget/ui/ui_constants.dart';

import 'add_image_container.dart';
import 'reminder_date_widget.dart';

class SaveReminderPage extends StatefulWidget {
  @override
  _SaveReminderPageState createState() => _SaveReminderPageState();
}

class _SaveReminderPageState extends State<SaveReminderPage> with GGValidators {
  final _reminderService = ReminderService();
  final _formKey = GlobalKey<FormState>();

  SettingsService _settingsService;
  NavigationBloc _navigationBloc;
  Reminder _reminder;

  @override
  void initState() {
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    _settingsService = SettingsService();
    if (_navigationBloc.getData() != null) {
      _reminder = _navigationBloc.getData() as Reminder;
    } else {
      _reminder = Reminder()..repetitionType = RepetitionType.onetimeOnly;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ReminderDateWidget(_reminder.date, onConfirm: _onConfirmDate),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    GGOutlinedTextFormField(
                      labelText: 'Título *',
                      textInputAction: TextInputAction.done,
                      initialValue: _reminder.title,
                      onSaved: (title) => _reminder.title = title,
                      validator: emptyValidator,
                    ),
                    formVerticalSeparator,
                    GGOutlinedTextFormField(
                      labelText: 'Descrição *',
                      textInputAction: TextInputAction.done,
                      initialValue: _reminder.description,
                      onSaved: (description) =>
                          _reminder.description = description,
                      validator: emptyValidator,
                      minLines: 3,
                      maxLines: 5,
                    ),
                    formVerticalSeparator,
                    formVerticalSeparator,
                    formVerticalSeparator,
                    AddImageContainer(_reminder.assetImage,
                        onPickImage: _onPickImage),
                    formVerticalSeparator,
                    FindDropdown(
                      items: getAllRepetiton(),
                      label: "Tipo de Repetção",
                      onChanged: (String repetiton) =>
                          _reminder.repetitionType = getRepetiton(repetiton),
                      selectedItem:
                          getRepetitonString(_reminder.repetitionType),
                      showSearchBox: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FloatingActionButton(
          onPressed: _saveReminder,
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  Future<void> _saveReminder() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      if (_reminder.key != null) {
        await NotificationService.cancelNotification(_reminder.notificationId);
      }
      final settings = await _settingsService.getSettings();

      int notificationId;
      if (_reminder.repetitionType == RepetitionType.onetimeOnly) {
        notificationId = await _scheduleOnetimeOnlyNotification(settings);
      } else {
        notificationId = await _showPeriodicNotification(settings);
      }
      _reminder.notificationId = notificationId;
      await _reminderService.saveReminder(_reminder);
      GGSnackbar.success(
        message: 'Lembrete salvo com sucesso',
        context: context,
      );
    }
  }

  Future<int> _scheduleOnetimeOnlyNotification(Configurations settings) async {
    return await NotificationService.scheduleNotification(
      title: _reminder.title,
      body: _reminder.description,
      notificationDate: _reminder.date.subtract(
        Duration(hours: settings.hoursToNotificate),
      ),
    );
  }

  Future<int> _showPeriodicNotification(Configurations settings) async {
    final RepeatInterval repeatInterval =
        _reminder.repetitionType == RepetitionType.daily
            ? RepeatInterval.Daily
            : RepeatInterval.Weekly;
    return await NotificationService.showPeriodicNotification(
      title: _reminder.title,
      body: _reminder.description,
      interval: repeatInterval,
    );
  }

  void _onConfirmDate(DateTime dateTime) {
    setState(() => _reminder.date = dateTime);
  }

  void _onPickImage(File image) {
    _reminder.assetImage = image?.path;
  }

  @override
  void dispose() {
    _navigationBloc.cleanData();
    super.dispose();
  }
}
