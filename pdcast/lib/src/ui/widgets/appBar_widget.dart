import 'package:flutter/material.dart';
import 'package:pdcast/src/model/choice.dart';
import 'package:pdcast/src/ui/canal_lista_page.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _AppBarWidgetState extends State<AppBarWidget> {

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    if ( choice.sigla == "CONFIG") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => null),
      );
    } else {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CanalListaPage()),
      );     
    }
  }  

  @override
  Widget build(BuildContext context) {
    return AppBar(
            backgroundColor: Colors.black,
            title: Text('PdCast'),
            actions: <Widget>[
              PopupMenuButton<Choice>(
                onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return choices.skip(0).map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                    );
                  }).toList();
                },
              ),
            ],

            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Posts',
                  icon: Icon(Icons.new_releases)
                ),
                Tab(
                  text: 'Favoritos',
                  icon: Icon(Icons.favorite)
                ),
                Tab(
                  text: 'Downloads',
                  icon: Icon(Icons.file_download)
                ), 
              ],
            ),
          );
  }
}

/**
 * Cria o menu superior
 */
const List<Choice> choices = const <Choice>[
  const Choice(title: 'Editar meus canais', icon: Icons.directions_car, sigla: "EMC"),
  const Choice(title: 'Configuração', icon: Icons.directions_bike, sigla: "CONFIG"),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}