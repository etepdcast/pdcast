import 'package:flutter/material.dart';
import 'package:pdcast/src/model/podCast.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';

class AbaFavoritosWidget extends StatefulWidget {
  @override
  _AbaFavoritosWidgetState createState() => _AbaFavoritosWidgetState();
}

class _AbaFavoritosWidgetState extends State<AbaFavoritosWidget> {
final List<PodCast> podcasts = <PodCast>[
    PodCast(nome: 'A Politica como Ela É', autor: 'Autor 016'),
    PodCast(nome: 'Academia CBN', autor: 'Autor 017'),
    PodCast(nome: 'Autoesporte na CBN', autor: 'Autor 018'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: podcasts.length,
        itemBuilder: (BuildContext context, int index) {
          return PodCastWidget(podCast: podcasts[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
