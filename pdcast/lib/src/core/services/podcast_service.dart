import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdcast/locator.dart';
import 'package:pdcast/src/core/daos/podcast_dao.dart';
import 'package:pdcast/src/core/models/podCast.dart';

class PodCastService extends ChangeNotifier {
  PodCastDao _api = locator<PodCastDao>();

  List<PodCast> podCasts;

  Future<List<PodCast>> fetchPodCasts() async {
    var result = await _api.getDataCollection();
    podCasts = result.documents
        .map((doc) => PodCast.fromMap(doc.data, doc.documentID))
        .toList();
    return podCasts;
  }

  Stream<QuerySnapshot> fetchPodCastsAsStream(String idAutor) {
    return _api.streamDataCollection(idAutor);
  }

  Future<PodCast> getPodCastById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  PodCast.fromMap(doc.data, doc.documentID) ;
  }

  Future removePodCast(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }
  
  Future updatePodCast(PodCast data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addPodCast(PodCast data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return result;
  }

  Future<QuerySnapshot> getByField(dynamic campo, String operador, String valor) async {
    var result = await _api.getByField(campo, operador, valor);
    return result;
  }  

}