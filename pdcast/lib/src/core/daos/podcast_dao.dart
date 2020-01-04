import 'package:cloud_firestore/cloud_firestore.dart';

class PodCastDao {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  PodCastDao() {
    ref = _db.collection( 'podcasts' );
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.document(id).updateData(data) ;
  }
  Future<QuerySnapshot> getByField(dynamic campo, String operador, String valor) {
    return ref.where(campo, isEqualTo: valor).getDocuments();
    //.where("nome", isEqualTo: "jamilton")
    //.where("idade", isEqualTo: 31)
    //.where("idade", isGreaterThan: 15)//< menor, > maior, >= maior ou igual, <= menor ou igual
    //.where("idade", isLessThan: 30)
    //descendente (do maior para o menor) ascendente (do menor para o maior)
    //.orderBy("idade", descending: true )
    //.orderBy("nome", descending: false )
    //.limit(1)
    // .where("nome", isGreaterThanOrEqualTo: pesquisa)
    // .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff" )

    //return null;//Future(querySnapshot) ;
  }
}