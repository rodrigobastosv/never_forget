import 'package:bloc_provider/bloc_provider.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:rxdart/rxdart.dart';

class SettingsBloc implements Bloc {
  final settingsService = SettingsService();
  final settingsController = BehaviorSubject<Configurations>.seeded(null);

  Stream<Configurations> get settingsStream => settingsController.stream;

  Configurations getConfigurations() {
    return settingsController.value;
  }

  void initConfigurations(Configurations configurations) {
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
