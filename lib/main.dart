import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:never_forget/theme/nf_theme.dart';
import 'package:path_provider/path_provider.dart';

import 'core/service/notification_service.dart';
import 'enum/repetition_type.dart';
import 'model/reminder.dart';
import 'page/home_page.dart';

void main() {
  NotificationService.setupLocalNotification();
  runApp(App());
}

class App extends StatelessWidget {
  Future<void> _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(ReminderAdapter(), 35);
    Hive.registerAdapter(RepetitionTypeAdapter(), 35);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Never Forget',
      theme: nfTheme,
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
}
