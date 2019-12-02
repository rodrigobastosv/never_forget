import 'package:flutter/material.dart';

class NFAppBar {
  static PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('Never Forget'),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
