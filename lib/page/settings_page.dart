import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:never_forget/core/bloc/settings_bloc.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<Configurations> futurePrefs;
  SettingsBloc settingsBloc;
  SettingsService settingsService;

  @override
  void initState() {
    settingsService = SettingsService();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    futurePrefs = settingsService.getSettings();
    initConfigs();
    super.initState();
  }

  void initConfigs() async {
    settingsBloc.initConfigurations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Configurations>(
      future: futurePrefs,
      builder: (_, snapshotPrefs) {
        if (snapshotPrefs.hasData) {
          final configsFromPrefs = snapshotPrefs.data;

          return StreamBuilder<Configurations>(
            stream: settingsBloc.settingsStream,
            initialData: configsFromPrefs,
            builder: (_, snapshot) {
              final pickedPreferences = snapshot.data;
              return Scaffold(
                appBar: AppBar(
                  title: Text('Preferências'),
                  centerTitle: true,
                ),
                body: SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'Geral',
                      tiles: [
                        SettingsTile(
                          title: 'Idioma',
                          subtitle: pickedPreferences.languageId.toString(),
                          leading: Icon(Icons.language),
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Notificações',
                      tiles: [
                        SettingsTile(
                          title: 'Horas de antecedência para notificar',
                          subtitle:
                              '${pickedPreferences.hoursToNotificate == 1 ? '1 hora' : '${pickedPreferences.hoursToNotificate} horas'}',
                          leading: Icon(Icons.timer),
                          onTap: () async {
                            final pickedValue = await showDialog(
                              context: context,
                              builder: (_) => NumberPickerDialog.integer(
                                minValue: 1,
                                maxValue: 10,
                                initialIntegerValue:
                                    pickedPreferences.hoursToNotificate,
                              ),
                            );
                            if (pickedValue != null) {
                              settingsBloc.updateHoursToNotificate(pickedValue);
                            }
                          },
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Aparência',
                      tiles: [
                        SettingsTile.switchTile(
                          title: 'Modo Escuro',
                          leading: Icon(Feather.moon),
                          switchValue: pickedPreferences.darkMode,
                          onToggle: settingsBloc.updateDarkMode,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
