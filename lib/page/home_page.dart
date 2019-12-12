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
                    appBar: AppBar(
                      title: Text(
                        'NeverForget',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    body: navigationBloc.getPageWidget(page),
                    bottomNavigationBar: BottomNavyBar(
                      selectedIndex: page.index,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      showElevation: true,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      onItemSelected: (index) =>
                          navigationBloc.navigateToPageByIndex(index),
                      items: [
                        _buildBottomNavBarItem(
                          iconData: Icons.add,
                          title: 'Adicionar',
                        ),
                        _buildBottomNavBarItem(
                          iconData: Icons.format_list_numbered,
                          title: 'Lembretes',
                        ),
                        _buildBottomNavBarItem(
                          iconData: Icons.calendar_today,
                          title: 'Calendário',
                        ),
                        _buildBottomNavBarItem(
                          iconData: Icons.settings,
                          title: 'Preferências',
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
      },
    );
  }

  BottomNavyBarItem _buildBottomNavBarItem({IconData iconData, String title}) {
    return BottomNavyBarItem(
      icon: Icon(iconData),
      title: Text(title),
      activeColor: Theme.of(context).primaryColorDark,
      inactiveColor: Theme.of(context).primaryColor,
    );
  }
}
