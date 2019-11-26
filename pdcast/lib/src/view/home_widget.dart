import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdcast/src/model/choice.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin{
  
  int _selectedIndex= 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex= index;
    });
  }

  Choice _selectedChoice = choices[0]; // The app's "state".

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }  
  
  final List<String> entries = <String>['Post A', 'Post B',
    'Post C', 'Post D', 'Post E', 'Post F', 'Post G'];
  final List<int> colors = <int>[600, 500, 100, 800, 600, 500, 100];

  @override
  Widget build(BuildContext context) {

    // Fixa a tela do app
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);    

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    color: Colors.amber[colors[index]],
                    child: Center(child: Text('Entry ${entries[index]}')),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),
              Icon(Icons.favorite),
              Icon(Icons.file_download),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                title: Text('Business'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                title: Text('School'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
} 

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Meus canais', icon: Icons.directions_car),
  const Choice(title: 'Configuração', icon: Icons.directions_bike),
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

//   @override
//   Widget build(BuildContext context) {


//     double _width= MediaQuery.of(context).size.width;
//     double _height= (MediaQuery.of(context).size.height -136);

//     double _heightSessionFav  = 100;
//     double _heightSessionBody = _height - _heightSessionFav;
//     double _heightSessionPdCastHead = 40;
//     double _heightSessionPPdCastBody = _heightSessionBody - _heightSessionPdCastHead;

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(160,198,207, 1),
//       appBar: AppBar(
//         title: const Text('PdCast'),
//         backgroundColor: Colors.black,
//         actions: <Widget>[
//           // overflow menu
//           PopupMenuButton<Choice>(
//             onSelected: _select,
//             itemBuilder: (BuildContext context) {
//               return choices.map((Choice choice) {
//                 return PopupMenuItem<Choice>(
//                   value: choice,
//                   child: Text(choice.title),
//                 );
//               }).toList();
//             },
//           ),
//         ],        
//       ),
//       body: Center(
//         child: Container (
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
          
//               /** 
//                * Favorites session
//                */
//               Container(
//                 width: _width,
//                 height: _heightSessionFav,
//                 padding: EdgeInsets.all(0),
//                 alignment: Alignment.center,  
//                 color: Colors.white,              
//                 child: GridView.count(
//                   scrollDirection: Axis.horizontal,
//                   // Cria um grid com duas colunas
//                   crossAxisCount: 1,
//                   // Gera 100 Widgets que exibem o seu índice
//                   children: List.generate(5, (index) {
//                     return Center(
//                       child: Text(
//                         'Item $index',
//                         style: Theme.of(context).textTheme.headline,
//                       ),
//                     );
//                   }),
//                 )
//               ),
              
//               /** 
//                * Podcats session
//                */   
//               Container(
//                 height: _heightSessionBody,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       height: _heightSessionPdCastHead,
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        // crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           Text('Geral'),
//                           Text('Acompanhando'),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: _heightSessionPPdCastBody,  
//                       padding: EdgeInsets.all(0),
//                       alignment: Alignment.center,  
//                       color: Colors.white,                                 
//                       child: GridView.count(
//                         scrollDirection: Axis.vertical,
//                         // Cria um grid com duas colunas
//                         crossAxisCount: 1,
//                         // Gera 100 Widgets que exibem o seu índice
//                         children: List.generate(30, (index) {
//                           return Center(    
//                             child: Container(
//                               color: Colors.blue,
//                               height: 30,
//                               child: Text(
//                                 'PodCast $index'
//                               ),
//                             )
//                           );
//                         }),
//                       )
//                     ),
//                   ],
//                 )
//               )
//             ],
//           ),
//         )
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.home),
//             title: Text('Home'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             title: Text('Business'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             title: Text('School'),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),        
//     );
//   }

// }

// const List<Choice> choices = const <Choice>[
//   const Choice(title: 'Meus canais', icon: Icons.change_history),
//   const Choice(title: 'Configurações', icon: Icons.settings_overscan),
// ];

// class ChoiceCard extends StatelessWidget {
//   const ChoiceCard({Key key, this.choice}) : super(key: key);

//   final Choice choice;

//   @override
//   Widget build(BuildContext context) {
//     final TextStyle textStyle = Theme.of(context).textTheme.display1;
//     return Card(
//       color: Colors.white,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(choice.icon, size: 128.0, color: textStyle.color),
//             Text(choice.title, style: textStyle),
//           ],
//         ),
//       ),
//     );
//   }
// }