import 'package:get_it/get_it.dart';

import 'service/reminder_service.dart';
import 'service/settings_service.dart';

GetIt getIt = GetIt.I;

void initSingletons() {
  getIt.registerSingleton<ReminderService>(ReminderService());
  getIt.registerSingleton<SettingsService>(SettingsService());
}

ReminderService getReminderService() {
  return getIt<ReminderService>();
}

SettingsService getSettingsService() {
  return getIt<SettingsService>();
}
