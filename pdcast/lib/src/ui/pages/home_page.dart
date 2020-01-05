import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdcast/src/core/models/choice.dart';
import 'package:pdcast/src/ui/pages/configuracao_page.dart';
import 'package:pdcast/src/ui/pages/podcast_lista_page.dart';
import 'package:pdcast/src/ui/widgets/aba_favoritos_widget.dart';
import 'package:pdcast/src/ui/widgets/aba_posts_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    if (choice.sigla == "CONFIG") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfiguracaoPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PodCastListaPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fixa a tela do app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff795548)),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          //appBar: AppBarWidget(),
          appBar: AppBar(
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
                  // icon: Icon(Icons.new_releases)
                ),
                Tab(
                  text: 'Favoritos',
                  // icon: Icon(Icons.favorite)
                ),
                // Tab(
                //   text: 'Downloads',
                //   icon: Icon(Icons.file_download)
                // ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AbaPostsWidget(),
              AbaFavoritosWidget(),
              // AbaDownloadsWidget(),
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
  const Choice(title: 'Meus podcast', icon: Icons.directions_car, sigla: "EMC"),
  const Choice(
      title: 'Configuração', icon: Icons.directions_bike, sigla: "CONFIG"),
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
