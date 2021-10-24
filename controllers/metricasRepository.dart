import 'dart:collection';
import 'package:get/get.dart';
import '/models/metricasModel.dart';
import '/database/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MetricasRepository extends GetxController {
  List<MetricasPrincipais> _lista = [
    MetricasPrincipais(
      idMetrica: "123312312",
      nomeMetrica: 'Número de participantes',
    )
  ].obs;
  late FirebaseFirestore db;

  MetricasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readMetricas();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readMetricas() async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db.collection(
        //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        'metricasPrincipais').get();
    for (var doc in snapshot.docs) {
      MetricasPrincipais table = MetricasPrincipais(
          idMetrica: doc['idMetrica'], nomeMetrica: doc['nomeMetrica']);
      _lista.add(table);
    }
    //}
  }

  sincronizaListaMetricas() {
    _lista.clear();
    _readMetricas();
  }

  UnmodifiableListView<MetricasPrincipais> get lista =>
      UnmodifiableListView(_lista);

  saveMetricaALl(List<MetricasPrincipais> listaMetrica) {
    listaMetrica.forEach((metrica) async {
      if (!_lista.any((atual) => atual.idMetrica == metrica.idMetrica)) {
        _lista.add(metrica);
        await db.collection(
            //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            'metricasPrincipais').doc(metrica.idMetrica.toString()).set({
          'idMetrica': metrica.idMetrica,
          'nomeMetrica': metrica.nomeMetrica,
        });
      }
    });
  }

  saveOneMetrica(String nomeMetrica) async {
    DocumentReference reference = await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('metricasPrincipais')
        //.doc(objetivo.idObjetivo.toString());
        .doc();

    MetricasPrincipais metrica =
        MetricasPrincipais(idMetrica: reference.id, nomeMetrica: nomeMetrica);

    _lista.add(metrica);

    await reference.set({
      'idMetrica': metrica.idMetrica,
      'nomeMetrica': metrica.nomeMetrica,
    });
  }

  remove(MetricasPrincipais metrica) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('metricasPrincipais')
        .doc(metrica.idMetrica)
        .delete();
    _lista.remove(metrica);
  }
  removeMetrica(String idMetrica) async {

    await db
    //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('metricasPrincipais')
        .doc(idMetrica)
        .delete();

    _lista.removeWhere((element) => element.idMetrica == idMetrica);
  }

  void atualizaMetrica(String idMetrica, String nomeMetricaAtualizado) async{
    int indice = _lista.indexWhere((element) => element.idMetrica == idMetrica);
    _lista[indice].nomeMetrica = nomeMetricaAtualizado;

    await db
    //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('metricasPrincipais')
        .doc(idMetrica)
        .update({
      'nomeMetrica': nomeMetricaAtualizado,
    });
    sincronizaListaMetricas();
  }
}
