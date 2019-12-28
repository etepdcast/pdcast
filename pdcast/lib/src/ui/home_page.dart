import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdcast/src/model/choice.dart';
import 'package:pdcast/src/model/podCast.dart';
import 'package:pdcast/src/ui/canal_lista_page.dart';
import 'package:pdcast/src/ui/configuracao_page.dart';
import 'package:pdcast/src/ui/widgets/appBar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    if ( choice.sigla == "CONFIG") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfiguracaoPage()),
      );
    } else {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CanalListaPage()),
      );     
    }
  }  

  final List<PodCast> podcasts = <PodCast>[
    PodCast(nome: 'A Cara do Brasil'),
    PodCast(nome: 'A BH que queremos'),
    PodCast(nome: 'A casa nômade'),
    PodCast(nome: 'A Semana política'),
    PodCast(nome: 'A nossa lingua de todo dia'),
    PodCast(nome: 'A Politica como Ela É'),
    PodCast(nome: 'Academia CBN'),
    PodCast(nome: 'Autoesporte na CBN'),
  ];

  final List<String> entries = <String>['Post A', 'Post B',
    'Post C', 'Post D', 'Post E', 'Post F', 'Post G'];
  final List<int> colors = <int>[600, 500, 100, 800, 600, 500, 100, 600];

  @override
  Widget build(BuildContext context) {

    // Fixa a tela do app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          //appBar: AppBarWidget(),
          appBar: AppBar(
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

          ),
          body: TabBarView(
            children: [
              ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: podcasts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[colors[index]],
                    child: Center(child: Text('${podcasts[index].nome}')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
              Icon(Icons.favorite),
              Icon(Icons.file_download),
            ],
          ),
        ),
      ),
    );
  }
} 

/*
 * Cria o menu superior
 */
const List<Choice> choices = const <Choice>[
  const Choice(title: 'Meus canais', icon: Icons.directions_car, sigla: "EMC"),
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