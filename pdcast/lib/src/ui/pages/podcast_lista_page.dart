import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/ui/pages/podcast_page.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';
import 'package:provider/provider.dart';

class PodCastListaPage extends StatefulWidget {
  @override
  _PodCastListaPageState createState() => _PodCastListaPageState();
}

class _PodCastListaPageState extends State<PodCastListaPage> {
  List<PodCast> podcasts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PodCastService>(context);

    return Scaffold(
      appBar: new AppBar(
          title: Text('PdCast > Meus canais'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Container(
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
                    });
              } else {
                return CircularProgressIndicator(
                    backgroundColor: Colors.cyan, semanticsLabel: 'Carregando');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        backgroundColor: Color(0xff795548),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PodCastPage(null)),
          );
        },
      ),
    );
  }
}
