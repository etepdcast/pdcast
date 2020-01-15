import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/ui/pages/home_page.dart';
import 'package:pdcast/src/ui/pages/podcast_page.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodCastListaPage extends StatefulWidget {
  @override
  _PodCastListaPageState createState() => _PodCastListaPageState();
}

class _PodCastListaPageState extends State<PodCastListaPage> {
  List<PodCast> podcasts;
  String _userId, _userNome;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString("userId");
      _userNome = prefs.getString("nome");
      print("= = = = = = = = = = = = = = = = = = = = = =");
      print("= = = uid  $_userId = = = =");
      print("= = = nome $_userNome = = = =");
      print("= = = = = = = = = = = = = = = = = = = = = =");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PodCastService>(context);

    return Scaffold(
      appBar: new AppBar(
          title: Text('PdCast > Meus canais'),
          backgroundColor: Color(0xff795548),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ),
          )),          
      body: Container(
        child: StreamBuilder(
            stream: provider.fetchPodCastsAsStream(_userId),
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
                return CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey
                );
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
