import 'package:flutter/material.dart';
import '../home_page.dart';
import 'guillotine_menu.dart';

class GuillotinePage extends StatefulWidget {
  @override
  _GuillotinePageState createState() => _GuillotinePageState();
}

class _GuillotinePageState extends State<GuillotinePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Container(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            HomePage(),
            GuillotineMenu(),
          ],
        ),
      ),
    );
  }
}