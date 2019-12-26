import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdcast/src/ui/home_page.dart';

final ThemeData temaIOS = ThemeData(
    primaryColor: Colors.grey[200],
    accentColor: Color(0xff25D366)
);

final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xff075E54),
    accentColor: Color(0xff25D366),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Platform.isIOS ? temaIOS : temaPadrao,
      home: HomePage()
    );
  }
}
