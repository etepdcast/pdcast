import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/services/podcast_service.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';
import 'package:provider/provider.dart';

class AbaFavoritosWidget extends StatefulWidget {
  @override
  _AbaFavoritosWidgetState createState() => _AbaFavoritosWidgetState();
}

class _AbaFavoritosWidgetState extends State<AbaFavoritosWidget> {
  List<PodCast> podcasts;

  @override
  Widget build(BuildContext context) {
      final provider = Provider.of<PodCastService>(context);
      //final provider = PodCastService();
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
                return Text('fetching');
              }
            }),
      );
  }
}
