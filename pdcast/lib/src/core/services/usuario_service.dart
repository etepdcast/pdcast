import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/locator.dart';
import 'package:pdcast/src/core/daos/usuario_dao.dart';
import 'package:pdcast/src/core/models/usuario.dart';

class UsuarioService extends ChangeNotifier {
  UsuarioDao _api = locator<UsuarioDao>();

  List<Usuario> usuarios;

  Future<List<Usuario>> fetchUsuarios() async {
    var result = await _api.getDataCollection();
    usuarios = result.documents
        .map((doc) => Usuario.fromMap(doc.data, doc.documentID))
        .toList();
    return usuarios;
  }

  Future<QuerySnapshot> getByField(String nome, String dataCadastro) async {
    return await _api.getByField(nome, dataCadastro);
  }

  Stream<QuerySnapshot> fetchUsuariosAsStream() {
    return _api.streamDataCollection();
  }

  Future<Usuario> getUsuarioById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Usuario.fromMap(doc.data, doc.documentID);
  }

  Future removeUsuario(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateUsuario(Usuario data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addUsuario(String hash, Usuario data) async {
    var result = await _api.addDocument(hash, data.toJson());
    return result;
  }
}
