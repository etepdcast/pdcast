import 'package:flutter/material.dart';
import 'package:pdcast/src/model/podCast.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';

class AbaPostsWidget extends StatefulWidget {
  @override
  _AbaPostsWidgetState createState() => _AbaPostsWidgetState();
}

class _AbaPostsWidgetState extends State<AbaPostsWidget> {

 final List<PodCast> podcasts = <PodCast>[
    PodCast(nome: 'A Cara do Brasil', autor: 'Autor 01'),
    PodCast(nome: 'A BH que queremos', autor: 'Autor 02'),
    PodCast(nome: 'A casa nômade', autor: 'Autor 03'),
    PodCast(nome: 'A Semana política', autor: 'Autor 014'),
    PodCast(nome: 'A nossa lingua de todo dia', autor: 'Autor 015'),
    PodCast(nome: 'A Politica como Ela É', autor: 'Autor 016'),
    PodCast(nome: 'Academia CBN', autor: 'Autor 017'),
    PodCast(nome: 'Autoesporte na CBN', autor: 'Autor 018'),
  ];

  // final List<String> entries = <String>['Post A', 'Post B',
  //   'Post C', 'Post D', 'Post E', 'Post F', 'Post G'];
  // final List<int> colors = <int>[600, 500, 100, 800, 600, 500, 100, 600];

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