import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdcast/locator.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/core/services/usuario_service.dart';
import 'package:pdcast/src/ui/pages/screen_page.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<PodCastService>()),
        ChangeNotifierProvider(builder: (_) => locator<UsuarioService>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Platform.isIOS ? temaIOS : temaPadrao,
        home: ScreenPage()
      )
    );
  }
}
