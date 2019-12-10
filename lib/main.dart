import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:never_forget/core/bloc/menu_bloc.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/bloc/settings_bloc.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:never_forget/page/home_page.dart';
import 'package:never_forget/theme/nf_dark_theme.dart';
import 'package:never_forget/theme/nf_light_theme.dart';
import 'package:path_provider/path_provider.dart';

import 'core/service/notification_service.dart';
import 'enum/repetition_type.dart';
import 'model/reminder.dart';

Configurations initialPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.setupLocalNotification();
  initialPrefs = await initPreferencesIfNecessary();
  runApp(App());
}

Future<Configurations> initPreferencesIfNecessary() async {
  final settingsService = SettingsService();
  Configurations settings = await settingsService.getSettings();
  if (settings == null) {
    final firstConfig = Configurations();
    firstConfig.languageId = 1;
    firstConfig.hoursToNotificate = 7;
    firstConfig.darkMode = false;
    await settingsService.saveSettings(firstConfig);
    settings = await settingsService.getSettings();
  }
  return settings;
}

class App extends StatelessWidget {
  final settingsService = SettingsService();

  Future<void> _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(ReminderAdapter(), 1);
    Hive.registerAdapter(RepetitionTypeAdapter(), 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      creator: (_, __) => SettingsBloc(),
      child: Builder(
        builder: (context) => BlocProvider<MenuBloc>(
          creator: (_, __) => MenuBloc(),
          child: BlocProvider<NavigationBloc>(
            creator: (_, __) => NavigationBloc(),
            child: StreamBuilder<Configurations>(
              stream: BlocProvider.of<SettingsBloc>(context).settingsStream,
              initialData: initialPrefs,
              builder: (_, snapshot) {
                return MaterialApp(
                  title: 'Never Forget',
                  theme: (snapshot.data?.darkMode ?? initialPrefs.darkMode) ? nfDarkTheme : nfLightTheme,
                  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: const <Locale>[Locale('pt', 'BR')],
                  home: FutureBuilder<void>(
                    future: _initHive(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return HomePage();
                      }
                      return Container();
                    },
                  ),
                  debugShowCheckedModeBanner: false,
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
