import 'package:flutter/material.dart';
import 'package:pdcast/src/core/models/podCast.dart';
import 'package:pdcast/src/core/utils/utils.dart';
import 'package:pdcast/src/ui/widgets/pod_cast_widget.dart';

class AbaPostsWidget extends StatefulWidget {
  @override
  _AbaPostsWidgetState createState() => _AbaPostsWidgetState();
}

class _AbaPostsWidgetState extends State<AbaPostsWidget> {

 final List<PodCast> podcasts = <PodCast>[
    PodCast(id: "#01", nome: 'A Cara do Brasil', autor: 'Autor 01', categoria: Utils.categoriaArte),
    PodCast(id: "#02", nome: 'A BH que queremos', autor: 'Autor 02', categoria: Utils.categoriaMatematica),
    PodCast(id: "#03", nome: 'A casa nômade', autor: 'Autor 03', categoria: Utils.categoriaPortugues),
    PodCast(id: "#04", nome: 'A Semana política', autor: 'Autor 014', categoria: Utils.categoriaQuimica),
    PodCast(id: "#05", nome: 'A nossa lingua de todo dia', autor: 'Autor 015', categoria: Utils.categoriaHistoria),
    PodCast(id: "#06", nome: 'A Politica como Ela É', autor: 'Autor 016', categoria: Utils.categoriaIngles),
    PodCast(id: "#07", nome: 'Academia CBN', autor: 'Autor 017', categoria: Utils.categoriaGeografia),
    PodCast(id: "#08", nome: 'Autoesporte na CBN', autor: 'Autor 018', categoria: Utils.categoriaBiologia),
    PodCast(id: "#09", nome: 'Educação ', autor: 'Autor 9384857', categoria: Utils.categoriaEmpreendedorismo),
    PodCast(id: "#10", nome: 'Celulas', autor: 'Paulo Rafael Lopes', categoria: Utils.categoriaEducFisica),
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