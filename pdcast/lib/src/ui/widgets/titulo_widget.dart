import 'package:flutter/material.dart';

class TituloWidget extends StatefulWidget {

  final String texto;
  const TituloWidget({Key key, this.texto});  

  @override
  _TituloWidgetState createState() => _TituloWidgetState();
  
}

class _TituloWidgetState extends State<TituloWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.texto,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}