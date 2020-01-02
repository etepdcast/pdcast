import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdcast/src/model/choice.dart';
import 'package:pdcast/src/ui/canal_lista_page.dart';
import 'package:pdcast/src/ui/configuracao_page.dart';
import 'package:pdcast/src/ui/widgets/aba_downloads_widget.dart';
import 'package:pdcast/src/ui/widgets/aba_favoritos_widget.dart';
import 'package:pdcast/src/ui/widgets/aba_posts_widget.dart';
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

 

  @override
  Widget build(BuildContext context) {

    // Fixa a tela do app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
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