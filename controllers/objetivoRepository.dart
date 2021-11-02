import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/database/db_firestore.dart';
import '/models/objetivosPrincipaisModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ObjetivosPrincipaisRepository extends GetxController {
  List<ObjetivosPrincipais> _lista = [
    ObjetivosPrincipais(
      idObjetivo: "1",
      nome: 'OBTER A CERTIFICAÇÃO 56002  PARA O SINDICATO',
      progresso: 100,
      importancia: 25,
      startAngle: 0,
      sweepAngle: 360,
    ),
    ObjetivosPrincipais(
      idObjetivo: "3",
      nome: '9001  PARA O SINDICATO',
      progresso: 50,
      importancia: 25,
      startAngle: 0,
      sweepAngle: 360,
    ),
  ].obs;
  late FirebaseFirestore db;

  ObjetivosPrincipaisRepository() {
    _startRepository();
  }
  // ObjetivosPrincipaisRepository({required this.auth}) {
  //   _startRepository();
  // }

  _startRepository() async {
    await _startFirestore();
    await _readObjetivos();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readObjetivos() async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db.collection(
        //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        'objetivosPrincipais').get();
    for (var doc in snapshot.docs) {
      ObjetivosPrincipais table = ObjetivosPrincipais(
        idObjetivo: doc['idObjetivo'],
        importancia: doc['importancia'],
        nome: doc['nome'],
        progresso: doc['progresso'],
        startAngle: doc['startAngle'],
        sweepAngle: doc['sweepAngle'],
      );
      _lista.add(table);
    }
    //}
  }

  sincronizaListaObjetivos() {
    _lista.clear();
    _readObjetivos();
  }

  UnmodifiableListView<ObjetivosPrincipais> get lista =>
      UnmodifiableListView(_lista);

  saveObj(List<ObjetivosPrincipais> objetivos) {
    objetivos.forEach((objetivo) async {
      if (!_lista.any((atual) => atual.idObjetivo == objetivo.idObjetivo)) {
        _lista.add(objetivo);
        await db.collection(
            //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            'objetivosPrincipais').doc(objetivo.idObjetivo.toString()).set({
          'idObjetivo': objetivo.idObjetivo,
          'nome': objetivo.nome,
          'progresso': objetivo.progresso,
          'importancia': objetivo.importancia,
          'startAngle': objetivo.startAngle,
          'sweepAngle': objetivo.sweepAngle,
        });
      }
    });
  }

  saveOneObjetivo(String nomeObjetivo) async {
    DocumentReference reference = await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('objetivosPrincipais')
        //.doc(objetivo.idObjetivo.toString());
        .doc();
    ObjetivosPrincipais objetivo = ObjetivosPrincipais(
      idObjetivo: reference.id,
      importancia: 25,
      nome: nomeObjetivo,
      progresso: 100,
      startAngle: 0,
      sweepAngle: 360,
    );

    _lista.add(objetivo);

    await reference.set({
      'idObjetivo': objetivo.idObjetivo,
      'nome': objetivo.nome,
      'progresso': objetivo.progresso,
      'importancia': objetivo.importancia,
    });
  }

  remove(ObjetivosPrincipais objetivo) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('objetivosPrincipais')
        .doc(objetivo.idObjetivo.toString())
        .delete();

    _lista.remove(objetivo);
  }

  removeObjetivo(String objetivo) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('objetivosPrincipais')
        .doc(objetivo)
        .delete();
    _lista.removeWhere((element) => element.idObjetivo == objetivo);
  }

  void atualizaObjetivo(
      String idObjetivo, String nomeObjetivoAtualizado) async {
    int indice =
        _lista.indexWhere((element) => element.idObjetivo == idObjetivo);
    print(indice);
    _lista[indice].nome = nomeObjetivoAtualizado;

    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('objetivosPrincipais')
        .doc(idObjetivo)
        .update({
      'nome': nomeObjetivoAtualizado,
    });
    sincronizaListaObjetivos();
  }
}
