import 'db_firestore.dart';
import '/models/usuario.dart';
import '/models/objetivo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = DBFirestore.get();

  Future<void> salvarObjetivo(ObjetivoModel objetivos) => _db
      .collection('Objetivo ')
      .doc('UIN7USDIU0K4lUE1MXzD')
      .set(objetivos.toMap());

  Stream<List<ObjetivoModel>> getObjetivos() {
    return _db.collection('Objetivo bootrukazu@gmail.com').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ObjetivoModel.fromFirestore(doc.data()))
            .toList());
  }

  Stream<List<Usuario>> getUsuarios() {
    return _db.collection('usuarios').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Usuario.fromFirestore(doc.data()))
        .toList()); //mudei fromMap
  }

  Future<void> removerObjetivo(String produtoId) {
    return _db
        .collection('Objetivo bootrukazu@gmail.com')
        .doc(produtoId)
        .delete();
  }

  // Sobre Projetos

  Future<void> getAllProjects() async{

    //Aqui é uma fotografia de todos os documentos no momento da consulta
    //Snapshot é diferente de Listen (que fica ouvindo as alterações)
    QuerySnapshot snapshot = await _db.collection("projetos").get();

    snapshot.docs.forEach((QueryDocumentSnapshot element) {
      print(element.data());
    });

    //TODO: transformar o JSON recebido em Objetos da model Projeto

    return;
  }

  Future<void> getOneProjectByDoc(String codigo) async{

    //Aqui é uma fotografia de todos os documentos no momento da consulta
    //Snapshot é diferente de Listen (que fica ouvindo as alterações)
    DocumentSnapshot snapshot = await _db.collection("projetos").doc(codigo).get();
    print(snapshot.data());

    return;
  }

  Future<void> getOneProjectByOwner(String codigo) async{

    //TODO:Modificar o código para filtrar pelo dono
    //Aqui é uma fotografia de todos os documentos no momento da consulta
    //Snapshot é diferente de Listen (que fica ouvindo as alterações)
    DocumentSnapshot snapshot = await _db.collection("projetos").doc(codigo).get();
    print(snapshot.data());

    return;
  }
/*
  Future<void> getOneProjectByOwner(String codigo) async{

    //Aqui é uma fotografia de todos os documentos no momento da consulta
    //Snapshot é diferente de Listen (que fica ouvindo as alterações)
    QuerySnapshot snapshot = await _db.collection("projetos").get();

    snapshot.docs.forEach((QueryDocumentSnapshot element) {
      print(element.data());
    });

    //TODO: transformar o JSON recebido em Objetos da model Projeto

    return;
  }
*/

}
