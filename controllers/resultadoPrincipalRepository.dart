import 'dart:collection';
import 'package:get/get.dart';
import '/database/db_firestore.dart';
import '/models/resultadoPrincipalModel.dart';
import '/models/donoResultadoMetricaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultadoPrincipalRepository extends GetxController {
  List<ResultadosPrincipais> _lista = [
    ResultadosPrincipais(
        idResultado: "1",
        nomeResultado: 'Obter certificação ISO 9001',
        idObjetivoPai: "",
        // idMetrica: "",
        donoResultado: <DonosResultadoMetricas>[])
  ].obs;
  late FirebaseFirestore db;

  ResultadoPrincipalRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readResultadosPrincipais();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readResultadosPrincipais() async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db.collection(
        //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        'resultadosPrincipais').get();
    for (var doc in snapshot.docs) {
      ResultadosPrincipais table = ResultadosPrincipais(
          idResultado: doc['idResultado'],
          nomeResultado: doc['nomeResultado'],
          idObjetivoPai: doc['idObjetivoPai'],
          // idMetrica: doc['idMetrica'],
          donoResultado: doc['donoResultado']);
      _lista.add(table);
    }
    //}
  }

  sincronizaListaResultados() {
    _lista.clear();
    _readResultadosPrincipais();
  }

  UnmodifiableListView<ResultadosPrincipais> get lista =>
      UnmodifiableListView(_lista);

  saveResultadosAll(List<ResultadosPrincipais> resultadosPrincipais) {
    resultadosPrincipais.forEach((resultado) async {
      if (!_lista.any((atual) => atual.idResultado == resultado.idResultado)) {
        _lista.add(resultado);
        await db.collection(
            //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            'resultadosPrincipais').doc(resultado.idResultado.toString()).set({
          'idResultado': resultado.idResultado,
          'nomeResultado': resultado.nomeResultado,
          'idObjetivoPai': resultado.idObjetivoPai,
          'donoResultado': resultado.donoResultado,
        });
      }
    });
  }

  saveOneResultadosPrincipais(
      String nomeResultado, String idObjetivoPai, String idMetrica, List<DonosResultadoMetricas> donos) async {
    DocumentReference reference = await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('resultadosPrincipais')
        //.doc(objetivo.idObjetivo.toString());
        .doc();

    ResultadosPrincipais resultadoPrincipal = ResultadosPrincipais(
        idResultado: reference.id,
        nomeResultado: nomeResultado,
        idObjetivoPai: idObjetivoPai,
        // idMetrica: idMetrica,
        donoResultado: donos);

    _lista.add(resultadoPrincipal);

    await reference.set({
      'idResultado': resultadoPrincipal.idResultado,
      'nomeResultado': resultadoPrincipal.nomeResultado,
      'idObjetivoPai': resultadoPrincipal.idObjetivoPai,
      'donoResultado': resultadoPrincipal.donoResultado,
    });
  }

  remove(ResultadosPrincipais resultadosPrincipais) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('resultadosPrincipais')
        .doc(resultadosPrincipais.idResultado)
        .delete();

    _lista.remove(resultadosPrincipais);
  }

  void removeResultado(String idResultado) async{
    await db
    //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('resultadosPrincipais')
        .doc(idResultado)
        .delete();
    _lista.removeWhere((element) => element.idResultado == idResultado);

  }

  void atualizaResultado(
      String idResultado, String nomeResultaAtualizado) async {
    int indice = _lista.indexWhere((element) => element.idResultado == idResultado);
    _lista[indice].nomeResultado = nomeResultaAtualizado;

    await db
    //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('resultadosPrincipais')
        .doc(idResultado)
        .update({
      'nomeResultado': nomeResultaAtualizado,
      //'donoResultado':
      //'idObjetivoPai':
    });
    sincronizaListaResultados();
  }

}
