import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

class NFBottomNavigationBar extends StatelessWidget {
  const NFBottomNavigationBar({this.selectedIndex, this.onChangedItem});

  final int selectedIndex;
  final Function(int) onChangedItem;

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBorderColor: Theme.of(context).primaryColorDark,
        selectedItemBackgroundColor: Theme.of(context).primaryColorDark,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Theme.of(context).primaryColorDark,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: onChangedItem,
      items: [
        FFNavigationBarItem(
          iconData: Icons.calendar_today,
          label: 'Calendário',
        ),
        FFNavigationBarItem(
          iconData: Icons.list,
          label: 'Lembretes',
        ),
        FFNavigationBarItem(
          iconData: Icons.add_circle,
          label: 'Adicionar',
        ),
        FFNavigationBarItem(
          iconData: Icons.adjust,
          label: 'Preferências',
        ),
      ],
    );
  }
}
