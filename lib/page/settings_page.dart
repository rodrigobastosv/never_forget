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
  Future<Configurations> futureBox;
  SettingsBloc settingsBloc;
  SettingsService settingsService;

  @override
  void initState() {
    settingsService = SettingsService();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    initConfigs();
    super.initState();
  }

  void initConfigs() async {
    settingsBloc.initConfigurations();
  }

  @override
  Widget build(BuildContext context) {
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
                subtitle: '1',
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
                '3 horas',
                leading: Icon(Icons.timer),
                onTap: () async {
                  final pickedValue = await showDialog(
                    context: context,
                    builder: (_) => NumberPickerDialog.integer(
                      minValue: 1,
                      maxValue: 10,
                      initialIntegerValue: 1,
                    ),
                  );
                  if (pickedValue != null) {
                    settingsBloc
                        .updateHoursToNotificate(pickedValue);
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
                switchValue: true,
                onToggle: settingsBloc.updateDarkMode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
