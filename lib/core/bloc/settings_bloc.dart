import 'package:bloc_provider/bloc_provider.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc implements Bloc {
  final settingsService = SettingsService();
  final settingsController = BehaviorSubject<Configurations>.seeded(
      Configurations()
        ..languageId = 1
        ..hoursToNotificate = 3
        ..darkMode = false
  );

  Stream<Configurations> get settingsStream => settingsController.stream;

  Configurations getConfigurations() {
    return settingsController.value;
  }

  void initConfigurations() async {
    final configurations = await settingsService.getSettings();
    settingsController.add(configurations);
  }

  void updateLanguage(int language) async {
    final config = await settingsService.getSettings();
    config.languageId = language;
    _updateConfigurations(config);
  }

  void updateHoursToNotificate(int hours) async {
    final config = await settingsService.getSettings();
    config.hoursToNotificate = hours;
    _updateConfigurations(config);
  }

  void updateDarkMode(bool darkMode) async {
    final config = await settingsService.getSettings();
    config.darkMode = darkMode;
    _updateConfigurations(config);
  }

  void _updateConfigurations(Configurations configurations) {
    settingsController.add(configurations);
    settingsService.saveSettings(configurations);
  }

  @override
  void dispose() {
    settingsController.close();
  }
}
