import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioDao {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  UsuarioDao() {
    ref = _db.collection('usuarios');
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Future<QuerySnapshot> getByField(String nome, String dataCadastro) {
    return ref
        .where("nome", isEqualTo: "$nome")
        .where("dataCadastro", isEqualTo: "$dataCadastro")
        .orderBy("nome")
        .limit(1)
        .getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(String hash, Map data) {
    return ref.document(hash).setData(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
