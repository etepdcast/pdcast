import 'package:flutter/material.dart';
import 'package:pdcast/locator.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/core/services/usuario_service.dart';
import 'package:pdcast/src/ui/pages/screen_page.dart';
import 'package:provider/provider.dart';

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
        theme: ThemeData(
          primaryColor: Color(0xff795548)),
        home: ScreenPage()));
  }
}
