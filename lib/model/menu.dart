import 'package:flutter/material.dart';

class Menu {
  Menu({this.title, this.icon, this.onTap, this.isPicked});

  String title;
  IconData icon;
  Function onTap;
  bool isPicked;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Menu &&
              runtimeType == other.runtimeType &&
              title == other.title;

  @override
  int get hashCode => title.hashCode;

  @override
  String toString() {
    return 'Menu{title: $title, icon: $icon, isPicked: $isPicked}';
  }
}