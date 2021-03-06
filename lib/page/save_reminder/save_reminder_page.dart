import 'dart:io';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gg_flutter_components/form/gg_text_form_field_shadowed.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/core/service/notification_service.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/enum/repetition_type.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:never_forget/model/reminder.dart';
import 'package:never_forget/ui/ui_constants.dart';
import 'package:never_forget/widget/nf_scaffold.dart';

import 'add_image_container.dart';
import 'reminder_date_widget.dart';

class SaveReminderPage extends StatefulWidget {
  const SaveReminderPage(this.page);
  final Page page;

  @override
  _SaveReminderPageState createState() => _SaveReminderPageState();
}

class _SaveReminderPageState extends State<SaveReminderPage> with GGValidators {
  final _reminderService = getReminderService();
  final _formKey = GlobalKey<FormState>();

  SettingsService _settingsService;
  NavigationBloc _navigationBloc;
  Reminder _reminder;

  @override
  void initState() {
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    _settingsService = getSettingsService();
    if (_navigationBloc.getData() != null) {
      _reminder = _navigationBloc.getData() as Reminder;
    } else {
      _reminder = Reminder()..repetitionType = RepetitionType.onetimeOnly;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NFScaffold(
      selectedIndex: widget.page.index,
      actions: <Widget>[
        Container(
          width: 56,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: RaisedButton(
            child: Icon(Icons.done, size: 28),
            color: Colors.green,
            textColor: Colors.white,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: _saveReminder,
          ),
        ),
      ],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    formVerticalSeparator,
                    GGTextFormFieldShadowed(
                      labelText: 'Título *',
                      textInputAction: TextInputAction.done,
                      initialValue: _reminder.title,
                      onSaved: (title) => _reminder.title = title,
                      validator: emptyValidator,
                    ),
                    formVerticalSeparator,
                    GGTextFormFieldShadowed(
                      labelText: 'Descrição *',
                      minLines: 3,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      initialValue: _reminder.description,
                      onSaved: (description) =>
                          _reminder.description = description,
                      validator: emptyValidator,
                    ),
                    formVerticalSeparator,
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: <Widget>[
                        ReminderDateWidget(
                          _reminder.date,
                          onConfirm: _onConfirmDate,
                        ),
                        FindDropdown(
                          showSearchBox: false,
                          items: getAllRepetiton(),
                          selectedItem:
                              getRepetitonString(_reminder.repetitionType),
                          onChanged: (String repetiton) => _reminder
                              .repetitionType = getRepetiton(repetiton),
                          dropdownBuilder: (
                            BuildContext context,
                            String repetitionType,
                          ) {
                            return Container(
                              width: 140,
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
                                  Text(
                                    'Tipo de Repetição',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    repetitionType ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    formVerticalSeparator,
                    formVerticalSeparator,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AddImageContainer(
                          _reminder.assetImage,
                          onPickImage: _onPickImage,
                        ),
                      ],
                    ),
                    formVerticalSeparator,
                  ],
                ),
              ),
            )
          ],
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
        if (_reminder.assetImage != null) {
          notificationId =
              await _scheduleOnetimeOnlyNotificationWithAsset(settings);
        } else {
          notificationId = await _scheduleOnetimeOnlyNotification(settings);
        }
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

  Future<int> _scheduleOnetimeOnlyNotificationWithAsset(
      Configurations settings) async {
    return await NotificationService.scheduleNotificationWithAsset(
      title: _reminder.title,
      body: _reminder.description,
      filePath: _reminder.assetImage,
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
