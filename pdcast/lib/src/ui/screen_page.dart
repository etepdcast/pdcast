import 'package:flutter/material.dart';
import 'package:pdcast/src/ui/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
            children: <Widget>[
            SplashScreen(
                seconds: 5,
                gradientBackground: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                    Color(0xffED213A),
                    Color(0xff93291E)
                ],
                ),
                navigateAfterSeconds: HomePage(),
                loaderColor: Colors.transparent,
            ),
            Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.scaleDown,
                ),
                ),
            ),
            ],
        );
  }
}
