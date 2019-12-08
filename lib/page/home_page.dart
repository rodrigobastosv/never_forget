import 'package:bloc_provider/bloc_provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/enum/page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReminderService _reminderService;

  @override
  void initState() {
    _reminderService = ReminderService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return FutureBuilder(
        future: _reminderService.openReminderBox(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<Page>(
              stream: navigationBloc.navigationStream,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  final page = snapshot.data;
                  return SafeArea(
                    child: Scaffold(
                      body: navigationBloc.getPageWidget(page),
                      bottomNavigationBar: BottomNavyBar(
                        selectedIndex: page.index,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        showElevation: true,
                        onItemSelected: (index) =>
                            navigationBloc.navigateToPageByIndex(index),
                        items: [
                          BottomNavyBarItem(
                            icon: Icon(Icons.add),
                            title: Text('Adicionar'),
                            activeColor: Theme.of(context).primaryColorDark,
                            inactiveColor: Theme.of(context).primaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: Icon(Icons.format_list_numbered),
                            title: Text('Lembretes'),
                            activeColor: Theme.of(context).primaryColorDark,
                            inactiveColor: Theme.of(context).primaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: Icon(Icons.calendar_today),
                            title: Text('Calendário'),
                            activeColor: Theme.of(context).primaryColorDark,
                            inactiveColor: Theme.of(context).primaryColor,
                          ),
                          BottomNavyBarItem(
                            icon: Icon(Icons.settings),
                            title: Text('Preferências'),
                            activeColor: Theme.of(context).primaryColorDark,
                            inactiveColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
