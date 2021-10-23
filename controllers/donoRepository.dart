import 'dart:collection';
import 'package:get/get.dart';
import '/database/db_firestore.dart';
import '/models/donoResultadoMetricaModel.dart';

//TODO: Implementar o AuthService conforme o vídeo
//import '/Authenticacao/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonoRepository extends GetxController {
  List<DonosResultadoMetricas> _lista = [
    DonosResultadoMetricas(
      id: "1",
      nome: 'Marianny Fidelis',
      email: "mariannyfidelis@hotmail",
    )
  ].obs;
  late FirebaseFirestore db;
  //late AuthService auth; //TODO: Aqui tem que ser o AuthService que temos que ver como funciona.

  DonoRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readDonos();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readDonos() async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db.collection(
        //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        'donosPrincipais').get();
    for (var doc in snapshot.docs) {
      DonosResultadoMetricas table = DonosResultadoMetricas(
          id: doc['id'],
          nome: doc['nome'],
          email: doc['email']);
      _lista.add(table);
    }
    //}
  }

  sincronizaListaDonos() {
    _lista.clear();
    _readDonos();
  }

  UnmodifiableListView<DonosResultadoMetricas> get lista =>
      UnmodifiableListView(_lista);

  saveDonoALl(List<DonosResultadoMetricas> donoResultadoMetrica) {
    donoResultadoMetrica.forEach((dono) async {
      if (!_lista.any((atual) => atual.id == dono.id)) {
        _lista.add(dono);
        await db.collection(
            //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            'donosPrincipais').doc(dono.id.toString()).set({
          'id': dono.id,
          'nome': dono.nome,
          'email': dono.email,
        });
      }
    });
  }

  saveOneDonoResultadoMetrica(String nomeDonoResultado, String emailDonoResultado) async {
    DocumentReference reference = await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('donosPrincipais')
        //.doc(objetivo.idObjetivo.toString());
        .doc();

    DonosResultadoMetricas dono = DonosResultadoMetricas(
        id: reference.id,
        nome: nomeDonoResultado,
        email: emailDonoResultado);

    _lista.add(dono);

    await reference.set({
      'id': dono.id,
      'nome': dono.nome,
      'email': dono.email,
    });
  }

  remove(DonosResultadoMetricas donoResultadoMetrica) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('donosPrincipais')
        .doc(donoResultadoMetrica.id)
        .delete();
    _lista.remove(donoResultadoMetrica);
  }

  removeDono(String idDono) async {
    await db
    //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('donosPrincipais')
        .doc(idDono)
        .delete();
    _lista.removeWhere((element) => element.id == idDono);
  }

  void atualizaDono(String idDono, String novoDonoAtualizado, String emailNovoDono) async{
    int indice = _lista.indexWhere((element) => element.id == idDono);
    _lista[indice].nome = novoDonoAtualizado;
    _lista[indice].email= emailNovoDono;

    await db
    //.collection('lista_projetos_usuario/${auth.usuario!.uid}/projetosPrincipais/donosPrincipais')
        .collection('donosPrincipais')
        .doc(idDono)
        .update({
      'nome': novoDonoAtualizado,
      'email': emailNovoDono
    });

    sincronizaListaDonos();
  }
}
