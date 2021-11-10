import 'dart:core';
import 'dart:collection';
import 'dart:math';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '/services/auth_service.dart';
import '/models/project_model.dart';
import '/models/metricasModel.dart';
import '/database/db_firestore.dart';
import 'package:flutter/material.dart';
import '/models/permissaoACLModel.dart';
import '/models/resultadoPrincipalModel.dart';
import '/models/objetivosPrincipaisModel.dart';
import '/models/donoResultadoMetricaModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

MenuControllerDash menuControllerDash = MenuControllerDash.instance;
NavigationControllerDash navigationController =
    NavigationControllerDash.instance;

var auth = Get.find<AuthService>();
String idUsuario = auth.usuario!.uid;

class ControllerProjetoRepository extends GetxController {
  List<ProjectModel> _listaProjetos = <ProjectModel>[].obs;

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  var ultimoNivelClicado = 1.obs;
  var indice = (-1).obs;
  var indiceResult = (-1).obs;
  var filtragem = "publico".obs;
  var iconsProjeto = false.obs;

//==================== Objetivos mandala ======================
  var ultimoObjetivoClicado = "".obs;
  var nomeObjMandala = ''.obs;
  var progressoObj = 0.0.obs;
  var sweepAngle = 0.obs;
  var data = Timestamp.fromDate(DateTime.now()).obs;
  //String ultimoMetricaClicada = "";

  //===================Results mandala===================
  var ultimoResultadoClicado = "".obs;
  var nomeResultMandala = ''.obs;
  var progressoResult = 0.0.obs;

  //===================Projeto===========================
  var idProjeto = "".obs;
  var nome = "".obs;
  var proprietario = "".obs;
  var tipoProj = "".obs;

  var visivel = true.obs;
  var botaoProjeto = false.obs;
  var clicou = false.obs;
  var detalhes = "ocultar detalhes".obs;
  var iconDetalhes = Icons.arrow_drop_up_rounded.obs;

  var _objetivoController = TextEditingController().obs;

  List<ObjetivosPrincipais> _listObjects = <ObjetivosPrincipais>[].obs;

  List<DonosResultadoMetricas> _listDonos = <DonosResultadoMetricas>[].obs;

  List<ResultadosPrincipais> _listResults = <ResultadosPrincipais>[].obs;

  List<MetricasPrincipais> _listMetrics = <MetricasPrincipais>[].obs;

  List<ACL> _listAcl = <ACL>[].obs;

  late FirebaseFirestore db;

  ControllerProjetoRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await readProjects("todos");

    idProjeto.value = listaProjetos[0].idProjeto!;
    nome.value = listaProjetos[0].nome!;
    proprietario.value = listaProjetos[0].proprietario!;
    tipoProj.value = listaProjetos[0].tipoProj!;

    if (listaProjetos.isNotEmpty) {
      listaProjetos[0].objetivosPrincipais!.forEach((element) {
        _listObjects.clear();
        _listObjects.add(element);
      });
      listaProjetos[0].resultadosPrincipais!.forEach((element) {
        _listResults.clear();
        _listResults.add(element);
      });
      listaProjetos[0].listaDonos!.forEach((element) {
        _listDonos.clear();
        _listDonos.add(element);
      });
      listaProjetos[0].metricasPrincipais!.forEach((element) {
        _listMetrics.clear();
        _listMetrics.add(element);
      });

      await _readProjeto(idProjeto.value);
    }
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readProjeto(String id,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    final snapshot = await db.collection('projetosPrincipais').doc(id).get();

    print("Fiz um readProject ");
    print(snapshot.data());
    late ProjectModel proj;
    if (snapshot.data() != null) {
      proj = ProjectModel.fromJson(snapshot.data()!);
    }

    this.idProjeto.value = proj.idProjeto!;
    this.nome.value = proj.nome!;
    this.proprietario.value = proj.proprietario!;
    this.tipoProj.value = proj.tipoProj!;

    _listObjects.clear();
    proj.objetivosPrincipais!.forEach((element) {
      _listObjects.add(element);
      print("${element.nome} - ");
    });

    _listResults.clear();
    proj.resultadosPrincipais!.forEach((element) {
      _listResults.add(element);
      print("${element.nomeResultado} - ");
    });

    _listDonos.clear();
    proj.listaDonos!.forEach((element) {
      _listDonos.add(element);
      print("${element.nome} - ");
    });

    _listMetrics.clear();
    proj.metricasPrincipais!.forEach((element) {
      _listMetrics.add(element);
      print("${element.nomeMetrica} - ");
    });

    _listAcl.clear();
    proj.acl!.forEach((element) {
      _listAcl.add(element);
    });

    print(
        "Controller linha 173 - quantos objetivos e donos - ${_listObjects.length} ${_listDonos.length}");
    print("${this.idProjeto.string} ${this.proprietario.string}");
  }

  //======================= CRUD objetivos =====================================
  UnmodifiableListView<ObjetivosPrincipais> get listaObjectives =>
      UnmodifiableListView(_listObjects);

  void addOneObjective(String nomeObjetivo,
      {int importancia = 100,
      double progresso = 100,
      double? meta = 0.0,
      double? realizado = 0.0,
      Timestamp? dataVencimento}) async {
    var uuid = Uuid();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    ObjetivosPrincipais objetivo = ObjetivosPrincipais(
        idObjetivo: uuid.v4(),
        importancia: importancia,
        nome: nomeObjetivo,
        progresso: progresso,
        meta: meta,
        realizado: realizado,
        startAngle: 0,
        sweepAngle: 360,
        dataVencimento: Timestamp.fromDate(DateTime.now()));

    _listObjects.add(objetivo);

    //Tem que recalcular tudo
    double sweepFatia = 360 / _listObjects.length;
    double startAngle = 0;

    for (var objetivo in _listObjects) {
      objetivo.setStartAngle(startAngle);
      objetivo.setSweepAngle(sweepFatia);
      //TODO - falta configurar aqui o progresso e a importância
      startAngle += sweepFatia;

      var l_resultados = _listResults
          .where((element) => element.idObjetivoPai == objetivo.idObjetivo);
      var tamanhoPedacoResultado =
          (l_resultados.length == 0) ? 1 : l_resultados.length;
      var sweepResultFatia = sweepFatia / tamanhoPedacoResultado;
      var startAngleFilho = startAngle;
      for (var lr in l_resultados) {
        lr.setStartAngle(startAngleFilho);
        lr.setSweepAngle(sweepResultFatia);
        startAngleFilho += sweepResultFatia;
      }
    }
    var l = _listObjects.map((v) => v.toJson()).toList();
    var r = _listResults.map((v) => v.toJson()).toList();
    await reference
        .update({'objetivosPrincipais': l, 'resultadosPrincipais': r});
  }

  void atualizaObjetivo(String idObjetivo, String nomeObjetivoAtualizado,
      {int importancia = 100, int progresso = 100}) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);

    if (indice != -1) {
      _listObjects[indice].nome = nomeObjetivoAtualizado;
      var reference = await db
          //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
          .collection('projetosPrincipais')
          .doc(this.idProjeto.value);

      var l = _listObjects.map((v) => v.toJson()).toList();

      await reference.update({'objetivosPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Objetivo não encontrado !");
    }
  }

  removeObjetivo(String idObjetivo) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);
    var val = <Map<String, dynamic>>[];
    var valR = <Map<String, dynamic>>[];
    var valM = <Map<String, dynamic>>[];

    if (indice != -1) {
      var vinculo =
          _listResults.where((element) => element.idObjetivoPai == idObjetivo);

      for (var result in vinculo) {
        valR.add(result.toJson());
        var metrics = _listMetrics
            .where((element) => element.idResultado == result.idResultado);
        for (var metric in metrics) {
          valM.add(metric.toJson());
        }
      }
      for (var result in vinculo) {
        _listMetrics.removeWhere(
            (element) => element.idResultado == result.idResultado);
      }

      _listResults
          .removeWhere((element) => element.idObjetivoPai == idObjetivo);
      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var a = _listObjects.removeAt(indice);
      val.add(a.toJson());

      double sweepFatia = 360 / _listObjects.length;
      double startAngle = 0;

      for (var objetivo in _listObjects) {
        objetivo.setStartAngle(startAngle);
        objetivo.setSweepAngle(sweepFatia);

        var l_resultados = _listResults
            .where((element) => element.idObjetivoPai == objetivo.idObjetivo);
        var tamanhoPedacoResultado =
            (l_resultados.length == 0) ? 1 : l_resultados.length;
        var sweepResultFatia = sweepFatia / tamanhoPedacoResultado;
        var startAngleFilho = startAngle;
        for (var lr in l_resultados) {
          lr.setStartAngle(startAngleFilho);
          lr.setSweepAngle(sweepResultFatia);
          startAngleFilho += sweepResultFatia;
        }
        startAngle += sweepFatia;
      }

      reference.update({
        "objetivosPrincipais": FieldValue.arrayRemove(val),
        "metricasPrincipais": FieldValue.arrayRemove(valM),
        "resultadosPrincipais": FieldValue.arrayRemove(valR)
      }).then((_) {
        print("___success com projeto repository!");
      });
      var l = _listObjects.map((v) => v.toJson()).toList();
      var r = _listResults.map((v) => v.toJson()).toList();
      await reference
          .update({'objetivosPrincipais': l, 'resultadosPrincipais': r});
      //await reference.update({'objetivosPrincipais': l});
    } else {
      debugPrint("___Não encontrei o objetivo !");
    }
  }

//======================= CRUD resultado =====================================
  UnmodifiableListView<ResultadosPrincipais> get listaResultados =>
      UnmodifiableListView(_listResults);

  void addOneResultado(String nomeResultado,
      {String? idObjetivoPai = "idObjetivoPai",
      /*String idMetrica = "idMetrica",*/
      List<DonosResultadoMetricas?>? donos}) async {
    var uuid = Uuid();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    ResultadosPrincipais resultadosPrincipais = ResultadosPrincipais(
        idResultado: uuid.v4(),
        nomeResultado: nomeResultado,
        idObjetivoPai: idObjetivoPai,
        startAngle: 0.0,
        sweepAngle: 360.0,
        // idMetrica: idMetrica,
        donoResultado: (donos != null)
            ? (donos.isEmpty)
                ? []
                : donos
            : []);

    debugPrint("${resultadosPrincipais.startAngle}");
    debugPrint("${resultadosPrincipais.sweepAngle}");

    _listResults.add(resultadosPrincipais);

    int indiceObjetivo = _listObjects.indexWhere(
        (element) => element.idObjetivo == idObjetivoPai); //Calcular o índice
    var vinculoresult = _listResults.where((element) =>
        element.idObjetivoPai == idObjetivoPai); //Calcular os resultados irmãos

    var tamanhoPedacoResultado =
        (vinculoresult.length == 0) ? 1 : vinculoresult.length;

    if (indiceObjetivo != -1) {
      var startPai = _listObjects[indiceObjetivo].startAngle;
      var sweepPai = _listObjects[indiceObjetivo].sweepAngle;
      var finalPai = startPai + sweepPai;
      var fatiaResult = finalPai - startPai;

      double sweepFatia = (fatiaResult / tamanhoPedacoResultado);
      double startAngle = startPai;

      for (var result in _listResults) {
        if (result.idObjetivoPai == idObjetivoPai) {
          //TODO - falta configurar aqui o progresso e a importância
          result.setStartAngle(startAngle);
          result.setSweepAngle(sweepFatia);
          startAngle += sweepFatia;
        }
      }
    }

    var l = _listResults.map((v) => v.toJson()).toList();

    await reference.update({'resultadosPrincipais': l}); //[l]
  }

  void removeResultado(String idResultado) async {
    var idObjetivoPai;
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);
    var val = <Map<String, dynamic>>[];
    var valM = <Map<String, dynamic>>[];

    if (indice != -1) {
      idObjetivoPai = _listResults[indice].idObjetivoPai;

      var vinculoMetrica =
          _listMetrics.where((element) => element.idResultado == idResultado);

      for (var metric in vinculoMetrica) {
        valM.add(metric.toJson());
      }
      _listMetrics.removeWhere((element) => element.idResultado == idResultado);

      //Esse aqui
      var a = _listResults.removeAt(indice);
      val.add(a.toJson());

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      reference.update({
        "resultadosPrincipais": FieldValue.arrayRemove(val),
        "metricasPrincipais": FieldValue.arrayRemove(valM),
      }).then((_) {
        print("remoção de resultado do projeto repository!");

        //TODO - Pode ser que seja preciso pegar todo o cálculo de
        //ângulo e colocar aqui dentro do THEN
      });
      //Esse aqui

      //Deve-se atualizar os dados dos ângulos de desenho
      var vinculoresult = _listResults.where((element) =>
          element.idObjetivoPai ==
          idObjetivoPai); //Calcular os resultados irmãos

      int indiceObjetivo = _listObjects
          .indexWhere((element) => element.idObjetivo == idObjetivoPai);
      //Se não tiver irmão ganhará um pedaço todo!
      var tamanhoPedacoResultado =
          (vinculoresult.length == 0) ? 1 : vinculoresult.length;

      if (indiceObjetivo != -1) {
        var startPai = _listObjects[indiceObjetivo].startAngle;
        var sweepPai = _listObjects[indiceObjetivo].sweepAngle;
        var finalPai = startPai + sweepPai;
        var fatiaResult = finalPai - startPai;

        double sweepFatia = (fatiaResult / tamanhoPedacoResultado);
        double startAngle = startPai;
        for (var result in _listResults) {
          if (result.idObjetivoPai == idObjetivoPai) {
            result.setStartAngle(startAngle);
            result.setSweepAngle(sweepFatia);
            startAngle += sweepFatia;
            //sweep += sweep_fatia
          }
        }
      }

      var l = _listResults.map((v) => v.toJson()).toList();
      await reference.update({'resultadosPrincipais': l});
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

  void atualizaResultado(String idResultado,
      {String? nomeResultaAtualizado,
      String? idObjetivoPai,
      String? idMetrica = "",
      String? cor = "255-242-242-242",
      List<DonosResultadoMetricas>? dono}) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    if (indice != -1) {
      _listResults[indice].idObjetivoPai = idObjetivoPai;
      // _listResults[indice].idMetrica = idMetrica;

      if (nome != null) {
        _listResults[indice].nomeResultado = nomeResultaAtualizado;
      }

      if (cor != null) {
        _listResults[indice].paint = cor;
      }

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listResults.map((v) => v.toJson()).toList();

      await reference.update({'resultadosPrincipais': l});
      atualizaTudo(this.idProjeto.value);
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

//======================= CRUD donos =====================================

  UnmodifiableListView<DonosResultadoMetricas> get listaDonos =>
      UnmodifiableListView(_listDonos);

  void addOneDono(String nomeDono, String emailDono) async {
    var uuid = Uuid();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    DonosResultadoMetricas dono =
        DonosResultadoMetricas(id: uuid.v4(), nome: nomeDono, email: emailDono);
    _listDonos.add(dono);

    var d = _listDonos.map((v) => v.toJson()).toList();

    await reference.update({'listaDonos': d}); //[l]
  }

  void atualizaDono(String id, String nome, String email) async {
    int indice = _listDonos.indexWhere((element) => element.id == id);

    if (indice != -1) {
      _listDonos[indice].nome = nome;
      _listDonos[indice].email = email;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listDonos.map((v) => v.toJson()).toList();

      await reference.update({'listaDonos': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      debugPrint("Não encontrei o dono !");
    }
  }

  removeDono(String id) async {
    int indice = _listDonos.indexWhere((element) => element.id == id);
    var val2 = <DonosResultadoMetricas>[];
    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listDonos[indice]);
      var a = _listDonos.removeAt(indice);
      val.add(a.toJson());
      //val.add(_listObjects.elementAt(indice));

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);
      reference.update({"listaDonos": FieldValue.arrayRemove(val)}).then((_) {
        print("success com projeto repository!");
      });
    } else {
      debugPrint("Não encontrei o dono !");
    }
  }

//======================= CRUD metricas =====================================
  UnmodifiableListView<MetricasPrincipais> get listaMetricas =>
      UnmodifiableListView(_listMetrics);

  void addOneMetric(String nomeAtualizadoMetrica,
      {String? idResultado,
      double meta = 100,
      double realizado = 1,
      double progresso = 0}) async {
    var uuid = Uuid();
    var id = uuid.v4();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    MetricasPrincipais metrica = MetricasPrincipais(
        idMetrica: id,
        nomeMetrica: nomeAtualizadoMetrica,
        idResultado: idResultado);

    _listMetrics.add(metrica);

    var l = _listMetrics.map((v) => v.toJson()).toList();

    await reference.update({'metricasPrincipais': l}); //[l]

    //atualizaResultado(idResultado!, nomeResultaAtualizado, idMetrica: id);
    atualizaTudo(this.idProjeto.string);
  }

  void atualizaMetrica(String idMetrica, String nomeMetricaAtualizado,
      {String? idResultado,
      double? meta,
      double? realizado,
      double? progresso}) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].nomeMetrica = nomeMetricaAtualizado;
      _listMetrics[indice].idResultado = idResultado;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listMetrics.map((v) => v.toJson()).toList();

      await reference.update({'metricasPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  removeMetrica(String idMetrica) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listMetrics[indice]);
      var a = _listMetrics.removeAt(indice);
      val.add(a.toJson());

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);
      reference.update(
          {"metricasPrincipais": FieldValue.arrayRemove(val)}).then((_) {
        print("success com projeto repository!");
      });
    } else {
      debugPrint("Não encontrei a métrica !");
    }
  }
//========================== METAS ATUALIZA E TRAVA ============================

  void travarMetaMetrica(
      int? periodo, String idMetrica, double metaTravada) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      if (periodo == 1) {
        _listMetrics[indice].meta1 = metaTravada;
      } else if (periodo == 2) {
        _listMetrics[indice].meta2 = metaTravada;
      } else if (periodo == 3) {
        _listMetrics[indice].meta3 = metaTravada;
      } else if (periodo == 4) {
        _listMetrics[indice].meta4 = metaTravada;
      } else {}

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listMetrics.map((v) => v.toJson()).toList();

      await reference.update({'metricasPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  void travaMetaResul(String idResultado, double meta) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    if (indice != -1) {
      _listResults[indice].meta = meta;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listResults.map((v) => v.toJson()).toList();

      await reference.update({'resultadosPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  void travaMetaObj(String idObj, double meta) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObj);

    if (indice != -1) {
      _listObjects[indice].meta = meta;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listObjects.map((v) => v.toJson()).toList();

      await reference.update({'objetivosPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  metasResulMetric(String? idResultado) {
    final vinculo =
        _listMetrics.where((element) => element.idResultado == idResultado);

    double metaResult = 0;

    for (final vin in vinculo) {
      print(vin.nomeMetrica);
      metaResult += vin.meta1! + vin.meta2! + vin.meta3! + vin.meta4!;
      print('${vin.meta1!}, ${vin.meta2!}, ${vin.meta3!}, ${vin.meta4!}');
    }
    print('objetivo total $metaResult');
    return metaResult;
  }

  metaObjetivos(String idObjetivo) {
    final vinculo =
        _listResults.where((element) => element.idObjetivoPai == idObjetivo);

    double metaObj = 0;

    for (final vin in vinculo) {
      print(vin.nomeResultado);
      metaObj += vin.meta!;
      print(vin.meta!);
    }
    print('objetivo total $metaObj');
    return metaObj;
  }

  // metaDonos(String id, String email, String nome) {
  //   final vinculo = _listObjects.where((element) =>
  //       element.donos ==
  //       element.donos!.where((element) => element.email == email));
  //   print(vinculo);
  //   double metaObj = 0;
  //   // if (vinculo != null) {
  //   //   print('objetivo encontrado');
  //   for (final vin in vinculo) {
  //     print(vin.nome);
  //     metaObj += vin.meta!;
  //     print(vin.meta!);
  //     print('objetivo total $metaObj');
  //   }
  //   // } else
  //   //   print('nao achei');

  //   return metaObj;
  // }

  void atualizarRealizado(String idMetrica, double realizado) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].realizado1 = realizado;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listMetrics.map((v) => v.toJson()).toList();

      await reference.update({'metricasPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

//========================== CRUD TODOS OS PROJETOS =====================================

  UnmodifiableListView<ProjectModel> get listaProjetos =>
      UnmodifiableListView(_listaProjetos);

  readProjects(String? tipo) async {
    _listaProjetos.clear();
    var snapshot;
    if (tipo != "todos") {
      if (tipo == "privado") {
        snapshot = await db
            .collection('projetosPrincipais')
            //.where('tipoProj', isEqualTo: tipo)
            .where("proprietario", isEqualTo: auth.usuario!.uid)
            .get();
      } else if (tipo == "compartilhado") {
        //TODO - Lista de Donos
        //TODO: Verificar como compartilhar !!!
        //       .where("listaDonos", arrayContainsAny: Dono.toJson)
        //       .get();
        //   'listaDonos', arrayContainsAny: [
        // {
        // 'email': 'brunolucas2001@gmail.com',
        // 'id': 'EsxJseqqSiNUaR7zISUgusvQjZQ2',
        // 'nome': 'Bruno Lucas'
        // }
        // ])

      } else if (tipo == "publico") {
        snapshot = await db
            .collection('projetosPrincipais')
            .where('tipoProj', isEqualTo: tipo)
            .get();
      } else {}
      if (snapshot != null) {
        for (var doc in snapshot.docs) {
          print("teste");
          ProjectModel table = ProjectModel.fromJson(doc.data());
          _listaProjetos.add(table);
        }
      }
    }
  }

  sincronizaListaProjects(String tipoProjeto) {
    _listaProjetos.clear();
    readProjects(tipoProjeto);
  }

  saveProjetoALl(List<ProjectModel> projectModel) {
    int i = 1;
    projectModel.forEach((project) async {
      print(i.toString());
      await db
          .collection(
              //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
              'projetosPrincipais')
          .doc(project.idProjeto.toString())
          .set(project.toJson());
      if (!_listaProjetos
          .any((atual) => atual.idProjeto == project.idProjeto)) {
        _listaProjetos.add(project);
        print('$i-.1');
        await db
            .collection(
                //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
                'projetosPrincipais')
            .doc(project.idProjeto.toString())
            .set(project.toJson());
      }
      i++;
    });
  }

  void addOneProject(String nome) async {
    var uuid = Uuid();
    String idProjeto = uuid.v4();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(idProjeto);

    ProjectModel newProject = ProjectModel(
      nome: nome,
      objetivosPrincipais: [],
      resultadosPrincipais: [],
      metricasPrincipais: [],
      listaDonos: [],
      idProjeto: idProjeto,
      proprietario: auth.usuario!.uid,
      tipoProj: 'privado',
      acl: [],
    );

    _listaProjetos.add(newProject);

    await reference.set(newProject.toJson());
  }

  void atualizaNomeProjeto(String idProj, String nomeAtualizado,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    String? tipo;

    int indice =
        _listaProjetos.indexWhere((element) => element.idProjeto == idProj);

    _listaProjetos.forEach((element) {
      if (element.idProjeto == idProj) {
        element.nome = nomeAtualizado;
        debugPrint("tem sim e modifiquei para : [${element.nome}]");
      }
    });

    if (indice != -1) {
      _listaProjetos[indice].nome = nomeAtualizado;
      //tipo = _listaProjetos[indice].tipoProj;
      debugPrint("tem sim um projeto");
      this.nome.value = nomeAtualizado;
      this.tipoProj.value = _listaProjetos[indice].tipoProj!;

      var reference = await db.collection('projetosPrincipais').doc(idProj);

      await reference.update({'nome': nomeAtualizado});
    } else {
      print("Projeto não encontrado !");
    }

    sincronizaListaProjects(this.tipoProj.value);
  }

  void removeProjeto(String idProjeto, String idUsuario) async {
    var reference = await db.collection("projetosPrincipais").doc(idProjeto);

    _listaProjetos.removeWhere((element) => element.idProjeto == idProjeto);
    reference.delete();
  }

  void remove(ProjectModel projeto,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    var reference = await db
        .collection("projetosPrincipais")
        .doc(projeto.idProjeto)
        .delete();
    _listaProjetos.remove(projeto);
  }

  void atualizaTudo(String idProjeto) {
    _readProjeto(idProjeto);
  }

  ProjectModel? getProjectModel() {
    return ProjectModel(
        proprietario: this.proprietario.value,
        nome: this.nome.value,
        idProjeto: this.idProjeto.value,
        tipoProj: this.tipoProj.value,
        listaDonos: this._listDonos,
        objetivosPrincipais: this._listObjects,
        resultadosPrincipais: this._listResults,
        metricasPrincipais: this._listMetrics,
        acl: this._listAcl);
  }

  int get niveis {
    if (listaObjectives.isNotEmpty && listaResultados.isNotEmpty) {
      return 3; //três níveis
    } else if (listaObjectives.isNotEmpty && listaResultados.isEmpty) {
      return 2;
    } else {
      return 1;
    }
  }

  int get nv {
    return this.niveis - 1;
  }

  Paint criaPaintObjective({String? converteCor}) {
    var r,g,b,a;
    if (converteCor == null) {
      r = Random().nextInt(40) + 215;
      g = Random().nextInt(40) + 215;
      b = Random().nextInt(40) + 215;
      a = 255;
    } else {
      var listaRGB = converteCor.split("-");
      a = int.parse(listaRGB[0]);
      r = int.parse(listaRGB[1]);
      g = int.parse(listaRGB[2]);
      b = int.parse(listaRGB[3]);
    }

    //TODO - Como colocar sombra e elevação
    Paint p = Paint()
      ..strokeWidth = 30
      ..color = Color.fromARGB(a, r, g, b)//RGBO(r, g, b, a)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;
    return p;
  }

  //==============================================CRUD MANDALA========================================================
  void atualizaObjetivoMandala(
    String idObjetivo, {
    String? nomeObjetivo,
    //TODO: mudar de importancia para progresso geral
    int? importancia,
    double? progresso,
    double? metaObj = 0.0,
    double? realizado = 0.0,
    String? cor = "255-242-242-242",
  }) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);

    if (indice != -1) {
      if (nomeObjetivo != null) {
        _listObjects[indice].nome = nomeObjetivo;
        var reference = await db
            //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            .collection('projetosPrincipais')
            .doc(this.idProjeto.value);

        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }
      if (progresso != null) {
        _listObjects[indice].progresso = progresso;
        var reference = await db
            //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            .collection('projetosPrincipais')
            .doc(this.idProjeto.value);

        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }
      if (cor != null) {
        var reference = await db
            //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
            .collection('projetosPrincipais')
            .doc(this.idProjeto.value);

        _listObjects[indice].paint = cor;
        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Objetivo não encontrado !");
    }
  }

  //=============================================SUSPENDER USER====================================================
  mudarAtivo(
    bool ativo,
    String idDoCara,
  ) {
    var reference = db.collection('usuarios').doc(idDoCara);

    (ativo)
        ? reference.update({'ativo': false})
        : reference.update({'ativo': true});
  }

  mudarEdit(
    bool editor,
    String idDoCara,
  ) {
    var reference = db.collection('usuarios').doc(idDoCara);

    (editor)
        ? reference.update({'editor': false})
        : reference.update({'editor': true});
  }

  void changeVisibilidade() {
    visivel.value = !visivel.value;
    clicou.value = !clicou.value;
    if (!visivel.value) {
      detalhes.value = "mostrar detalhes";
      iconDetalhes.value = Icons.arrow_drop_down_rounded;
    } else {
      detalhes.value = "ocultar detalhes";
      iconDetalhes.value = Icons.arrow_drop_up_rounded;
    }
  }

  void changeDataVencimento(
      Timestamp dateTime, ObjetivosPrincipais objetivoModel) {
    objetivoModel.setDataVencimento(dateTime);
  }

  void atualizaPedaco(String nomeAtualizado) {
    if (ultimoNivelClicado.value == 2) {
      atualizaObjetivoMandala(ultimoObjetivoClicado.value,
          nomeObjetivo: nomeAtualizado);
    } else if (ultimoNivelClicado.value == 3) {
      atualizaResultado(ultimoResultadoClicado.value,
          nomeResultaAtualizado: nomeAtualizado);
    } else {}
  }

  void atualizaCor(String corAtualizada) {
    if (ultimoNivelClicado.value == 2) {
      atualizaObjetivoMandala(ultimoObjetivoClicado.value, cor: corAtualizada);
    } else if (ultimoNivelClicado.value == 3) {
      atualizaResultado(ultimoResultadoClicado.value, cor: corAtualizada);
    } else {}
  }

  TextEditingController get objetivoController {
    _objetivoController.value.text = (ultimoNivelClicado.value <= 2)
        ? (ultimoNivelClicado.value == 2)
            ? nomeObjMandala.value
            : nome.value
        : nomeResultMandala.value;

    return _objetivoController.value;
  }

  void mudaNome(String nomeAtualizado) {
    _objetivoController.value.text = nomeAtualizado;
  }

  gerarProgresso(
      double realizado1,
      double realizado2,
      double realizado3,
      double realizado4,
      double meta1,
      double meta2,
      double meta3,
      double meta4) {
    if (meta1 + meta2 + meta3 + meta4 != 0) {
      double progresso = ((realizado1 + realizado2 + realizado3 + realizado4) /
              (meta1 + meta2 + meta3 + meta4)) *
          100;
      return progresso;
    } else {
      return 0;
    }
  }

  ocultaCriarProjeto(String tipo) {
    if (tipo == 'cliente' && filtragem.value != "privado") {
      botaoProjeto.value = false;
    } else {
      (tipo == 'cliente')
          ? (_listaProjetos
                      .where((element) =>
                          element.proprietario == auth.usuario!.uid)
                      .length ==
                  0)
              ? botaoProjeto.value = true
              : botaoProjeto.value = false
          : botaoProjeto.value = true;
    }

    print(
        'BBB ${listaProjetos.where((element) => element.proprietario == auth.usuario!.uid).length}');
    return botaoProjeto.value;
  }

  visivelEditarProjeto() {
    if (filtragem.value != "privado") {
      iconsProjeto.value = false;
    } else {
      iconsProjeto.value = true;
    }
    return iconsProjeto.value;
  }

  void adicionarExtensao() {}

  void buscarExtensao() {}

  void adicionarResponsavel() {}

  void buscarResponsavel() {}

  void setStartAngle(int o, double anguloInicio) {
    _listObjects[o].setStartAngle(anguloInicio);
  }

  void setSweepAngle(int o, double sweep) {
    _listObjects[o].setSweepAngle(sweep);
  }
}
