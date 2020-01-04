import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/ui/pages/podcast_page.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';
import 'package:pdcast/src/ui/widgets/titulo_widget.dart';
import 'package:provider/provider.dart';

class PodCastListaPage extends StatefulWidget {
  @override
  _PodCastListaPageState createState() => _PodCastListaPageState();
}

class _PodCastListaPageState extends State<PodCastListaPage> {
    List<PodCast> podcasts;

  //   Future<List<PodCast>> _recuperarCanais() async {
  //   Firestore db = Firestore.instance;

  //   QuerySnapshot querySnapshot =
  //       await db.collection("canais").getDocuments();

  //   List<PodCast> listaCanais = List();
  //   for (DocumentSnapshot item in querySnapshot.documents) {

  //     var dados = item.data;
  //     // if( dados["email"] == _emailUsuarioLogado ) continue;

  //     PodCast podCast = PodCast();
  //     podCast.id = item.documentID;
  //     podCast.nome = dados["nome"];
  //     podCast.resumo = dados["resumo"];
  //     podCast.categoria = dados["categoria"];
  //     podCast.dataCriacao = dados["dataCriacao"];
  //     podCast.autor = dados["autor"];

  //     listaCanais.add(podCast);
  //   }

  //   return listaCanais;
  // }

  @override
  void initState() {
    super.initState();
    //_recuperarCanais();
  }

  Widget projectWidget() {
    final provider = Provider.of<PodCastService>(context);

    return Container(
      child: StreamBuilder(
        stream: provider.fetchPodCastsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            podcasts = snapshot.data.documents
                .map((doc) => PodCast.fromMap(doc.data, doc.documentID))
                .toList();
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: podcasts.length,
              itemBuilder: (buildContext, index) {
                  return PodCastWidget(podCast: podcasts[index]);
              }
            );
          } else {
            return CircularProgressIndicator(backgroundColor: Colors.cyan, semanticsLabel: 'Carregando');
          }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
            backgroundColor: Colors.black,
            title: Text('PdCast > Meus canais'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Container(
              margin: new EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TituloWidget(texto: "Lista de canais"),
                  Container(
                    child: FlatButton.icon(
                      color: Colors.green,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        print("= = = = = = = = = = = BUTTON");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PodCastPage(null)),
                        );
                      },
                      icon: Icon(Icons.add),
                      label: Text('Adicionar novo podCast'),
                    ),
                  ), projectWidget(),
          // FutureBuilder<bool>(
          //   future: _future,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting)
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     else
          //       return Container(
          //         width: 100,
          //         height: 100,
          //         color: snapshot.data ? Colors.green : Colors.red,
          //       );
          //   },
          // ),

                  //projectWidget()
                  // Container(
                  //   child: FutureBuilder<List<PodCast>>(
                  //     future: _recuperarCanais(),
                  //     builder: (context, snapshot) {
                  //       switch (snapshot.connectionState) {
                  //         case ConnectionState.none:
                  //         case ConnectionState.waiting:
                  //           return Center(
                  //             child: Column(
                  //               children: <Widget>[
                  //                 Text("Carregando canais"),
                  //                 CircularProgressIndicator()
                  //               ],
                  //             ),
                  //           );
                  //           break;
                  //         case ConnectionState.active:
                  //         case ConnectionState.done:
                  //           return ListView.builder(
                  //               itemCount: snapshot.data.length,
                  //               itemBuilder: (_, indice) {

                  //                 List<PodCast> listaItens = snapshot.data;
                  //                 PodCast podCast = listaItens[indice];

                  //                 return ListTile(
                  //                   onTap: (){
                  //                     Navigator.pushNamed(
                  //                         context,
                  //                         "/mensagens",
                  //                       arguments: podCast
                  //                     );
                  //                   },
                  //                   contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  //                   // leading: CircleAvatar(
                  //                   //     maxRadius: 30,
                  //                   //     backgroundColor: Colors.grey,
                  //                   //     backgroundImage: usuario.urlImagem != null
                  //                   //         ? NetworkImage(usuario.urlImagem)
                  //                   //         : null),
                  //                   title: Text(
                  //                     podCast.nome,
                  //                     style:
                  //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  //                   ),
                  //                 );
                  //               });
                  //           break;
                  //       }
                  //     },
                  // ))
                ],
              ),
        ),
      ),
    );
  }
}



