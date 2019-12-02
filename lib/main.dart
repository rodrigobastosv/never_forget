import 'package:flutter/material.dart';
import 'package:never_forget/theme/nf_theme.dart';

import 'page/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Never Forget',
      theme: nfTheme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}