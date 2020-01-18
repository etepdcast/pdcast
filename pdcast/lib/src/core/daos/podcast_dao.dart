import 'package:cloud_firestore/cloud_firestore.dart';

class PodCastDao {
  final Firestore _db = Firestore.instance;
  CollectionReference ref;

  PodCastDao() {
    ref = _db.collection('podcasts');
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection(String idAutor) {
    if (idAutor == null) {
      print(" > > > > > > > > > > > > > > > > > > > > > > > >");
      print(" > > > > > >  streamDataCollection > ref.snapshots");
      return ref.snapshots();
    } else {
      print(" > > > > > > > > > > > > > > > > > > > > > > > >");
      print(" > > > > > >  streamDataCollection > ref.where autor isEqualTo $idAutor");
      return ref.where("autor", isEqualTo: idAutor).snapshots();
    }
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }

  Future<QuerySnapshot> getByField(
      dynamic campo, String operador, String valor) {
    return ref.where(campo, isEqualTo: valor).getDocuments();
  }
}
