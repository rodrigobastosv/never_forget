import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({this.navigateTo});

  final Function(int) navigateTo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('SEETINGS PAGE'),
      ),
    );
  }
}
