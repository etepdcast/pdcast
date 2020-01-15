import 'package:flutter/material.dart';
import 'package:pdcast/src/ui/pages/home_page.dart';
import 'package:pdcast/src/ui/pages/login_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch( settings.name ){
      case "/" :
        return MaterialPageRoute(
          builder: (_) => LoginPage()
        );
      case "/login" :
        return MaterialPageRoute(
            builder: (_) => LoginPage()
        );
      case "/home" :
        return MaterialPageRoute(
            builder: (_) => HomePage()
        );
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(title: Text("Tela não encontrada!"),),
          body: Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      }
    );
  }

}