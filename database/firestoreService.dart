import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';
import '/models/usuario.dart';
import '/models/objetivo_model.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

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
}
