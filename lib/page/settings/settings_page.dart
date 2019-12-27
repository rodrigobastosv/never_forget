import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:never_forget/core/bloc/settings_bloc.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/core/service/settings_service.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/model/configurations.dart';
import 'package:never_forget/widget/nf_scaffold.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(this.page);
  final Page page;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsBloc settingsBloc;
  SettingsService settingsService;
  Future<Configurations> configsFuture;

  @override
  void initState() {
    settingsService = getSettingsService();
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    configsFuture = settingsService.getSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: configsFuture,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final pickedPreferences = snapshot.data;
          return NFScaffold(
            selectedIndex: widget.page.index,
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(24),
                      child: SettingsList(
                        sections: [
                          SettingsSection(
                            title: 'Geral',
                            tiles: [
                              SettingsTile(
                                title: 'Idioma',
                                subtitle: 'Português',
                                leading: Icon(Icons.language),
                              ),
                            ],
                          ),
                          SettingsSection(
                            title: 'Notificações',
                            tiles: [
                              SettingsTile(
                                title:
                                    'Horas de antecedência para notificar (para notificações sem repetição)',
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
                                    settingsBloc
                                        .updateHoursToNotificate(pickedValue);
                                  }
                                },
                              ),
                            ],
                          ),
                          /* DESABILITADO PRA FUTURA MELHORIA
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
                    */
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          );
        } else {
          return NFScaffold(
            selectedIndex: widget.page.index,
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
