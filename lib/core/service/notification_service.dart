import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Random _random;

  static Future<void> setupLocalNotification() async {
    _random = Random();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_event');
    final initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  static Future<void> _onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

  static NotificationDetails _getNotificationDetails({
    String channelId = 'ID',
    String channelName = 'NAME',
    String channelDescription = 'DESCRIPTION',
    String groupKey = 'GROUP-KEY',
    Importance importance = Importance.Max,
    Priority priority = Priority.High,
  }) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName, channelDescription,
        importance: importance,
        priority: priority,
        groupKey: groupKey,
        ticker: 'ticker');

    return NotificationDetails(androidPlatformChannelSpecifics, null);
  }

  static int _getRandomId() {
    return _random.nextInt(50000);
  }

  static Future<List<PendingNotificationRequest>>
      getPendingNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<NotificationAppLaunchDetails>
      getNotificationAppLaunchDetails() async {
    return await flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<int> showInstantNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );
    final id = _getRandomId();
    await flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails, payload: payload);
    return id;
  }

  static Future<int> showPeriodicNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required RepeatInterval interval,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );
    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, interval, notificationDetails,
        payload: payload);
    return id;
  }

  static Future<int> showDailyNotificationAtTime(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required Time time,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, notificationDetails,
        payload: payload);
    return id;
  }

  static Future<int> showWeeklyNotificationAtTimeAndWeekDay(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required Day day,
      @required Time time,
      @required String title,
      String body,
      String payload}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id, title, body, day, time, notificationDetails);
    return id;
  }

  static Future<int> scheduleNotification(
      {String channelId = 'ID',
      String channelName = 'NAME',
      String channelDescription = 'DESCRIPTION',
      Importance importance = Importance.Max,
      Priority priority = Priority.High,
      @required String title,
      String body,
      String payload,
      @required DateTime notificationDate}) async {
    final notificationDetails = _getNotificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      priority: priority,
    );

    final id = _getRandomId();
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, notificationDate, notificationDetails,
        payload: payload);
    return id;
  }
}
