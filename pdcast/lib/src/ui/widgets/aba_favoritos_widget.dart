import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/utils/utils.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';

class AbaFavoritosWidget extends StatefulWidget {
  @override
  _AbaFavoritosWidgetState createState() => _AbaFavoritosWidgetState();
}

class _AbaFavoritosWidgetState extends State<AbaFavoritosWidget> {
final List<PodCast> podcasts = <PodCast>[
    PodCast(id: "#01", nome: 'A Cara do Brasil', autor: 'Autor 01', categoria: Utils.categoriaArte),
    PodCast(id: "#02", nome: 'A BH que queremos', autor: 'Autor 02', categoria: Utils.categoriaMatematica),
    PodCast(id: "#03", nome: 'A casa nômade', autor: 'Autor 03', categoria: Utils.categoriaPortugues),
    PodCast(id: "#04", nome: 'A Semana política', autor: 'Autor 014', categoria: Utils.categoriaQuimica),
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
