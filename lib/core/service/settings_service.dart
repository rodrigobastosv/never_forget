import 'dart:convert';

import 'package:never_forget/model/configurations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class SettingsService {
  Future<Configurations> getSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final configurations = Configurations();
    final configs = prefs.getString(SETTINGS);
    if (configs != null) {
      return configurations.fromJson(jsonDecode(configs));
    }
    return null;
  }

  Future<void> saveSettings(Configurations configurations) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SETTINGS, jsonEncode(configurations.toJson()));
  }
}