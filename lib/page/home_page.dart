import 'package:bloc_provider/bloc_provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';
import 'package:never_forget/core/locator.dart';
import 'package:never_forget/core/service/reminder_service.dart';
import 'package:never_forget/enum/page.dart';
import 'package:never_forget/widget/nf_scaffold.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ReminderService _reminderService = getReminderService();

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
                  child: navigationBloc.getPageWidget(page)
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
}
