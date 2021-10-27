import 'db_firestore.dart';
import '/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = DBFirestore.get();

  Stream<List<Usuario>> getUsuarios() {
    return _db.collection('usuarios').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Usuario.fromFirestore(doc.data()))
        .toList()); //mudei fromMap
  }

  Future<void> getAllProjects() async{
    QuerySnapshot snapshot = await _db.collection("projetos").get();
    snapshot.docs.forEach((QueryDocumentSnapshot element) {
      print(element.data());
    });
    return;
  }

  Future<void> getOneProjectByDoc(String codigo) async{

    //Aqui é uma fotografia de todos os documentos no momento da consulta
    //Snapshot é diferente de Listen (que fica ouvindo as alterações)
    DocumentSnapshot snapshot = await _db.collection("projetos").doc(codigo).get();
    print(snapshot.data());

    return;
  }
}
