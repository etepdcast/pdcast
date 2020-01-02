import 'package:flutter/material.dart';


//https://pt.stackoverflow.com/questions/380470/como-fa%C3%A7o-pra-calcular-tamanho-dos-widgets-para-diferentes-resolu%C3%A7%C3%B5es
class SizeConfig {

  final MediaQueryData mediaQueryData;
  final BuildContext context;

  SizeConfig({this.mediaQueryData, this.context});

  static SizeConfig of(BuildContext context) =>
      SizeConfig(mediaQueryData: MediaQuery.of(context));

  double dynamicScaleSize({double size, double scaleFactorTablet, double scaleFactorMini}) {
    if(isTablet()) {
      final scaleFactor = scaleFactorTablet ?? 2;
      return size * scaleFactor;
    }

    if(isMini()) {
      final scaleFactor = scaleFactorMini ?? 0.8;
      return size * scaleFactor;
    }

    return size;
  }

  /// Defines device type based on logical device pixels. Bigger than 600 means it is a tablet
  bool isTablet() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide > 600;
  }

  /// Defines device type based on logical device pixels. Less or equal than 320 means it is a mini device
  bool isMini() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide <= 320;
  }

  double getWidth() {
    return MediaQuery.of(context).size.width;
  }  

  double getHeight() {
    return MediaQuery.of(context).size.height;
  }    
}