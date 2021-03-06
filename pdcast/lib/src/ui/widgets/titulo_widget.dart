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
    return Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Text(
          widget.texto,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )));
  }
}
