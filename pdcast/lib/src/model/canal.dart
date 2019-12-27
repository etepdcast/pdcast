import 'package:pdcast/src/model/categoria.dart';

class Canal {
  // atributos
  String id;
  String nome;
  String descricao;
  Categoria categoria;

  // construtor
  Canal({this.nome, this.descricao, this.categoria});

}