import 'package:bloc_provider/bloc_provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:never_forget/core/bloc/navigation_bloc.dart';

class NFScaffold extends StatelessWidget {
  const NFScaffold({
    this.title = 'NeverForget',
    this.actions,
    this.bottom,
    this.selectedIndex,
    @required this.body,
  }) : assert(body != null);

  final String title;
  final List<Widget> actions;
  final Widget body;
  final Widget bottom;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(32),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0, 1.5),
                blurRadius: 2,
                color: Colors.grey,
              ),
            ],
          ),
          child: BottomNavyBar(
            selectedIndex: selectedIndex,
            itemCornerRadius: 32,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            showElevation: false,
            backgroundColor: Colors.transparent,
            onItemSelected: (index) =>
                navigationBloc.navigateToPageByIndex(index),
            items: [
              _buildBottomNavBarItem(
                context,
                iconData: Icons.add,
                title: 'Adicionar',
              ),
              _buildBottomNavBarItem(
                context,
                iconData: Icons.format_list_numbered,
                title: 'Lembretes',
              ),
              _buildBottomNavBarItem(
                context,
                iconData: Icons.calendar_today,
                title: 'Calendário',
              ),
              _buildBottomNavBarItem(
                context,
                iconData: Icons.settings,
                title: 'Preferências',
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavyBarItem _buildBottomNavBarItem(BuildContext context,
      {IconData iconData, String title}) {
    return BottomNavyBarItem(
      icon: Icon(
        iconData,
        color: Colors.grey[850],
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[850]),
      ),
      activeColor: Theme.of(context).primaryColor,
      inactiveColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
