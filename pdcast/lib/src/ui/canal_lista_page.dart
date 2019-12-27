import 'package:flutter/material.dart';

class CanalListaPage extends StatefulWidget {
  @override
  _CanalListaPageState createState() => _CanalListaPageState();
}

class _CanalListaPageState extends State<CanalListaPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Meus canais'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: Container(
              child: Text('CANAL'),
            )
          ),
        ),
      ),
    );
  }
}
