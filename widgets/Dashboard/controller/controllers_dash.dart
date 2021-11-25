import 'dart:core';
import 'dart:math';
import 'dart:typed_data';
import 'dart:collection';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

MenuControllerDash menuControllerDash = MenuControllerDash.instance;
NavigationControllerDash navigationController =
    NavigationControllerDash.instance;

var auth = Get.find<AuthService>();
String idUsuario = auth.id.value;

class ControllerProjetoRepository extends GetxController {
  List<ProjectModel> _listaProjetos = <ProjectModel>[].obs;

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  String? tipoArquivo="";
  var uploading = false.obs;
  var total = 0.0.obs;

  var dataInicio = DateTime.now().obs;
  var dataFinal  = DateTime.now().obs;

  var responsaveis = "".obs;
  var ultimoNivelClicado = 1.obs;
  var indiceObjective = (-1).obs;
  var indiceResult = (-1).obs;
  var filtragem = "publico".obs;
  var iconsProjeto = false.obs;
  var periodo = 2.0.obs;

//==================== Objetivos mandala ======================
  var ultimoObjetivoClicado = "".obs;
  var nomeObjMandala = ''.obs;
  var progressoObj = 0.0.obs;
  var progressoAtualObj = 0.0.obs;
  var data = Timestamp.fromDate(DateTime.now()).obs;

  //===================Results mandala===================
  var ultimoResultadoClicado = "".obs;
  var nomeResultMandala = ''.obs;
  var progressoResult = 0.0.obs;
  var progressoAtualResult = 0.0.obs;

  //==================Métricas mandala===================
  List<MetricasPrincipais> _metricasFiltradas = <MetricasPrincipais>[].obs;
  List<MetricasPrincipais> _responsaveisMetricas = <MetricasPrincipais>[].obs;

  //===================Projeto===========================
  var public = false.obs;
  var editor = false.obs;

  var permissaoCompartilhar = "pode ler".obs;
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

  Uint8List? _arquivoImagemSelecionado;
  var _nomeArquivoSelecionado = "".obs;

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

      listaProjetos[0].acl!.forEach((element) {
        _listAcl.clear();
        _listAcl.add(element);
      });

      await _readProjeto(idProjeto.value);
    }
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readProjeto(String id, {String idUsuario = ''}) async {
    final snapshot = await db.collection('projetosPrincipais').doc(id).get();

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
    acl();
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
      dataVencimento: Timestamp.fromDate(DateTime.now()),
      arquivos: <String>[],
      donos: [],
      extensao: [],
    );

    _listObjects.add(objetivo);

    //Tem que recalcular tudo
    double sweepFatia = 360 / _listObjects.length;
    double startAngle = 0;

    // ultimoNivelClicado.value = 2;
    // nomeObjMandala.value = objetivo.nome!;
    // progressoObj.value = 0.0;
    // progressoAtualObj.value = 0.0;
    // data.value = Timestamp.fromDate(DateTime.now());
    // ultimoObjetivoClicado.value = objetivo.idObjetivo!;

    for (var objetivo in _listObjects) {
      objetivo.setStartAngle(startAngle);
      objetivo.setSweepAngle(sweepFatia);
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
      indiceObjective.value = (-1);
      ultimoNivelClicado.value = 1;
      ultimoObjetivoClicado.value = "";
      nomeObjMandala.value = "";
      progressoObj.value = 0.0;
      progressoAtualObj.value = 0.0;
      data.value = Timestamp.fromDate(DateTime.now());

      indiceResult.value = (-1);
      nomeResultMandala.value = '';
      ultimoNivelClicado.value = 1;
      ultimoResultadoClicado.value = "";
      progressoResult.value = 0.0;
      progressoAtualResult.value = 0.0;

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
      donoResultado: (donos != null)
          ? (donos.isEmpty)
              ? []
              : donos
          : [],
      extensao: [],
      arquivos: [],
    );

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

      //TODO: Removido para tratar o erro do resultado selecionado
      // ultimoNivelClicado.value = 3;
      // ultimoResultadoClicado.value = resultadosPrincipais.idResultado!;
      // nomeResultMandala.value = resultadosPrincipais.nomeResultado!;
      // progressoResult.value = 0.0;
      // progressoAtualResult.value = 0.0;

      for (var result in _listResults) {
        if (result.idObjetivoPai == idObjetivoPai) {
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

      //Deve-se atualizar os dados dos ângulos de desenho
      var vinculoresult = _listResults.where((element) =>
          element.idObjetivoPai ==
          idObjetivoPai); //Calcular os resultados irmãos

      int indiceObjetivo = _listObjects
          .indexWhere((element) => element.idObjetivo == idObjetivoPai);
      //Se não tiver irmão ganhará toda a fatia disponínel!
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

      indiceResult.value = (-1);
      nomeResultMandala.value = '';
      ultimoNivelClicado.value = 1;
      ultimoResultadoClicado.value = "";
      progressoResult.value = 0.0;
      progressoAtualResult.value = 0.0;

      var l = _listResults.map((v) => v.toJson()).toList();
      await reference.update({'resultadosPrincipais': l});
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

  void atualizaResultado(
    String idResultado, {
    String? idObjetivoPai,
    String? nomeResultado,
    int? importancia,
    double? progresso,
    double? metaObj = 0.0,
    double? realizado = 0.0,
    String? arquivo,
    String? cor/*= "255-242-242-242"*/,
  }) async {
    var reference = await db
        .collection('projetosPrincipais')
        .doc(this.idProjeto.value);
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    if (indice != -1) {
      if (nomeResultado == null) {
        if (_listResults[indice].nomeResultado != null) {
          nomeResultado = _listResults[indice].nomeResultado;
        }
        _listResults[indice].nomeResultado = nomeResultado;
      }

      if (nomeResultado != null) {
        _listResults[indice].nomeResultado = nomeResultado;
      }
      if (idObjetivoPai == null) {
        if (_listResults[indice].idObjetivoPai != null) {
          idObjetivoPai = _listResults[indice].idObjetivoPai;
        }
        _listResults[indice].idObjetivoPai = idObjetivoPai;
      }
      if (idObjetivoPai != null) {
        _listResults[indice].idObjetivoPai = idObjetivoPai;
      }
      if (arquivo != null) {
        _listResults[indice].arquivos!.add(arquivo);

        var l = _listResults.map((v) => v.toJson()).toList();

        await reference.update({'resultadosPrincipais': l});
      }
      if (cor != null) {
        _listResults[indice].paint = cor;
        var l = _listResults.map((v) => v.toJson()).toList();

        await reference.update({'resultadosPrincipais': l});
      }

      var l = _listResults.map((v) => v.toJson()).toList();

      await reference.update({'resultadosPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Objetivo não encontrado !");
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
      double progresso = 0,
      String? unidade}) async {
    var uuid = Uuid();
    var id = uuid.v4();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    MetricasPrincipais metrica = (unidade != null)
        ? MetricasPrincipais(
            idMetrica: id,
            nomeMetrica: nomeAtualizadoMetrica,
            idResultado: idResultado,
            unidadeMedida: unidade)
        : MetricasPrincipais(
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
      double? progresso,
      String? unidade}) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].nomeMetrica = nomeMetricaAtualizado;
      _listMetrics[indice].idResultado = idResultado;

      if (unidade != null) {
        _listMetrics[indice].unidadeMedida = unidade;
      }

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
      var indexResult = _listResults.indexWhere(
          (element) => element.idResultado == _listMetrics[indice].idResultado);
      if (indexResult != -1) {
        //atualizando as metas de resultados

        double meta = _listResults[indexResult].meta!;
        double meta1 = _listResults[indexResult].meta1!;
        double meta2 = _listResults[indexResult].meta2!;
        double meta3 = _listResults[indexResult].meta3!;
        double meta4 = _listResults[indexResult].meta4!;

        meta -= (_listMetrics[indice].meta1! +
            _listMetrics[indice].meta2! +
            _listMetrics[indice].meta3! +
            _listMetrics[indice].meta4!);
        meta1 -= _listMetrics[indice].meta1!;
        meta2 -= _listMetrics[indice].meta2!;
        meta3 -= _listMetrics[indice].meta3!;
        meta4 -= _listMetrics[indice].meta4!;

        _listResults[indexResult].meta = meta;
        _listResults[indexResult].meta1 = meta1;
        _listResults[indexResult].meta2 = meta2;
        _listResults[indexResult].meta3 = meta3;
        _listResults[indexResult].meta4 = meta4;

        //atualizando os realizados de resultados

        _listResults[indexResult].realizado =
            _listResults[indexResult].realizado! -
                (_listMetrics[indice].realizado1! +
                    _listMetrics[indice].realizado2! +
                    _listMetrics[indice].realizado3! +
                    _listMetrics[indice].realizado4!);

        _listResults[indexResult].realizado1 =
            _listResults[indexResult].realizado1! -
                _listMetrics[indice].realizado1!;

        _listResults[indexResult].realizado2 =
            _listResults[indexResult].realizado2! -
                _listMetrics[indice].realizado2!;

        _listResults[indexResult].realizado3 =
            _listResults[indexResult].realizado3! -
                _listMetrics[indice].realizado3!;

        _listResults[indexResult].realizado4 =
            _listResults[indexResult].realizado4! -
                _listMetrics[indice].realizado4!;
      }
      debugPrint("zzz meta ${_listResults[indexResult].meta}");

      var lr = _listResults.map((r) => r.toJson()).toList();
      var a = _listMetrics.removeAt(indice);
      val.add(a.toJson());

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);
      reference.update({
        "metricasPrincipais": FieldValue.arrayRemove(val),
        'resultadosPrincipais': lr
      }).then((_) {
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

      var indexResult = _listResults.indexWhere(
          (element) => element.idResultado == _listMetrics[indice].idResultado);
      if (indexResult != -1) {
        _listResults[indexResult].meta =
            metasResulMetric(0.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].meta1 =
            metasResulMetric(1.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].meta2 =
            metasResulMetric(2.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].meta3 =
            metasResulMetric(3.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].meta4 =
            metasResulMetric(4.0, _listResults[indexResult].idResultado);
      }

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listMetrics.map((v) => v.toJson()).toList();
      var lr = _listResults.map((r) => r.toJson()).toList();
      await reference.update({
        'metricasPrincipais': l,
        'resultadosPrincipais': lr,
      });

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  // void travaMetaResul(String idResultado, double meta) async {
  //   int indice = _listResults
  //       .indexWhere((element) => element.idResultado == idResultado);
  //
  //   if (indice != -1) {
  //     _listResults[indice].meta = meta;
  //
  //     var reference =
  //         await db.collection('projetosPrincipais').doc(this.idProjeto.value);
  //
  //     var l = _listResults.map((v) => v.toJson()).toList();
  //
  //     await reference.update({'resultadosPrincipais': l});
  //
  //     atualizaTudo(this.idProjeto.value);
  //   } else {
  //     print("Métrica não encontrada !");
  //   }
  // }

  // void travaMetaObj(String idObj, double meta) async {
  //   int indice =
  //       _listObjects.indexWhere((element) => element.idObjetivo == idObj);
  //
  //   if (indice != -1) {
  //     _listObjects[indice].meta = meta;
  //
  //     var reference =
  //         await db.collection('projetosPrincipais').doc(this.idProjeto.value);
  //
  //     var l = _listObjects.map((v) => v.toJson()).toList();
  //
  //     await reference.update({'objetivosPrincipais': l});
  //
  //     atualizaTudo(this.idProjeto.value);
  //   } else {
  //     print("Métrica não encontrada !");
  //   }
  // }

  metasResulMetric(double periodo, String? idResultado) {
    final vinculo =
        _listMetrics.where((element) => element.idResultado == idResultado);

    double metaResult = 0;
    double meta1 = 0;
    double meta2 = 0;
    double meta3 = 0;
    double meta4 = 0;

    for (final vin in vinculo) {
      metaResult += vin.meta1! + vin.meta2! + vin.meta3! + vin.meta4!;
      meta1 += vin.meta1!;
      meta2 += vin.meta2!;
      meta3 += vin.meta3!;
      meta4 += vin.meta4!;
    }
    print('objetivo total $metaResult');
    if (periodo == 0.0) {
      return metaResult;
    } else if (periodo == 1.0) {
      return meta1;
    } else if (periodo == 2.0) {
      return meta2;
    } else if (periodo == 3.0) {
      return meta3;
    } else if (periodo == 4.0) {
      return meta4;
    } else {
      return '\nGeral : $metaResult\n\nQuarter 1 : $meta1\n\nQuarter 2 : $meta2\n\nQuarter 3 : $meta3\n\nQuarter 4 : $meta4\n';
    }
  }

  realizadoResulMetric(double? periodoAtual, String? idResultado) {
    final vinculo =
        _listMetrics.where((element) => element.idResultado == idResultado);

    double realizadoResult = 0;
    double realizado1 = 0;
    double realizado2 = 0;
    double realizado3 = 0;
    double realizado4 = 0;

    for (final vin in vinculo) {
      print(vin.nomeMetrica);
      realizadoResult +=
          vin.realizado1! + vin.realizado2! + vin.realizado3! + vin.realizado4!;
      realizado1 += vin.realizado1!;
      realizado2 += vin.realizado2!;
      realizado3 += vin.realizado3!;
      realizado4 += vin.realizado4!;
    }

    if (periodoAtual == 0.0) {
      return realizadoResult;
    } else if (periodoAtual == 1.0) {
      return realizado1;
    } else if (periodoAtual == 2.0) {
      return realizado2;
    } else if (periodoAtual == 3.0) {
      return realizado3;
    } else if (periodoAtual == 4.0) {
      return realizado4;
    } else {
      return '\nGeral : $realizadoResult\n\nQuarter 1 : $realizado1\n\nQuarter 2 : $realizado2\n\nQuarter 3 : $realizado3\n\nQuarter 4 : $realizado4\n';
    }
  }

  metaObjetivos(double? periodo, String idObjetivo) {
    final vinculo =
        _listResults.where((element) => element.idObjetivoPai == idObjetivo);

    double metaObj = 0;
    double meta1 = 0;
    double meta2 = 0;
    double meta3 = 0;
    double meta4 = 0;

    for (final vin in vinculo) {
      print(vin.nomeResultado);
      metaObj += vin.meta!;
      meta1 += vin.meta1!;
      meta2 += vin.meta2!;
      meta3 += vin.meta3!;
      meta4 += vin.meta4!;
      print(vin.meta!);
    }
    print('objetivo total $metaObj');
    if (periodo == 0.0) {
      return metaObj;
    } else if (periodo == 1.0) {
      return meta1;
    } else if (periodo == 2.0) {
      return meta2;
    } else if (periodo == 3.0) {
      return meta3;
    } else if (periodo == 4.0) {
      return meta4;
    } else {
      return '\nGeral : $metaObj\n\nQuarter 1 : $meta1\n\nQuarter 2 : $meta2\n\nQuarter 3 : $meta3\n\nQuarter 4 : $meta4\n';
    }
  }

  realizadoObjetivos(double periodoAtual, String idObjetivo) {
    final vinculo =
        _listResults.where((element) => element.idObjetivoPai == idObjetivo);

    double realizadoObj = 0;
    double realizado1 = 0;
    double realizado2 = 0;
    double realizado3 = 0;
    double realizado4 = 0;

    for (final vin in vinculo) {
      print(vin.nomeResultado);
      realizadoObj += vin.realizado!;
      realizado1 += vin.realizado1!;
      realizado2 += vin.realizado2!;
      realizado3 += vin.realizado3!;
      realizado4 += vin.realizado4!;
      print(vin.meta!);
    }

    if (periodoAtual == 0.0) {
      return realizadoObj;
    } else if (periodoAtual == 1.0) {
      return realizado1;
    } else if (periodoAtual == 2.0) {
      return realizado2;
    } else if (periodoAtual == 3.0) {
      return realizado3;
    } else if (periodoAtual == 4.0) {
      return realizado4;
    } else {
      return '\nGeral : $realizadoObj\n\nQuarter 1 : $realizado1\n\nQuarter 2 : $realizado2\n\nQuarter 3 : $realizado3\n\nQuarter 4 : $realizado4\n';
    }
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

  void atualizarRealizado(
      int periodo, String idMetrica, double realizado) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      if (periodo == 1) {
        _listMetrics[indice].realizado1 = realizado;
      } else if (periodo == 2) {
        _listMetrics[indice].realizado2 = realizado;
      } else if (periodo == 3) {
        _listMetrics[indice].realizado3 = realizado;
      } else if (periodo == 4) {
        _listMetrics[indice].realizado4 = realizado;
      } else {}

      var indexResult = _listResults.indexWhere(
          (element) => element.idResultado == _listMetrics[indice].idResultado);
      if (indexResult != -1) {
        _listResults[indexResult].realizado =
            realizadoResulMetric(0.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].realizado1 =
            realizadoResulMetric(1.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].realizado2 =
            realizadoResulMetric(2.0, _listResults[indexResult].idResultado);
        _listResults[indexResult].realizado3 =
            realizadoResulMetric(3, _listResults[indexResult].idResultado);
        _listResults[indexResult].realizado4 =
            realizadoResulMetric(4, _listResults[indexResult].idResultado);

        // var indexObj = _listObjects.indexWhere((element) =>
        //     element.idObjetivo == _listResults[indice].idObjetivoPai);
        // if (indexObj != -1) {
        //   _listObjects[indexObj].realizado =
        //       realizadoObjetivos(_listObjects[indexObj].idObjetivo!);
        // }
      }

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var lm = _listMetrics.map((m) => m.toJson()).toList();
      var lr = _listResults.map((r) => r.toJson()).toList();
      //var lo = _listObjects.map((o) => o.toJson()).toList();

      await reference.update({
        'metricasPrincipais': lm,
        'resultadosPrincipais': lr,
        //'objetivosPrincipais': lo
      });

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

//========================== CRUD TODOS OS PROJETOS =====================================

  UnmodifiableListView<ProjectModel> get listaProjetos =>
      UnmodifiableListView(_listaProjetos);

  Future<List<ProjectModel>> readProjects(String? tipo) async {
    _listaProjetos.clear();
    var snapshot;
    if (tipo != "todos") {
      if (tipo == "privado") {
        snapshot = await db
            .collection('projetosPrincipais')
            //.where('tipoProj', isEqualTo: tipo)
            .where("proprietario", isEqualTo: auth.id.value)
            .get();
      } else if (tipo == "compartilhado") {
        snapshot = await db
            .collection('projetosPrincipais')
            .where('acl', arrayContainsAny: [
          {'identificador': auth.email.value, 'permissao': 'pode ler'},
          {'identificador': auth.email.value, 'permissao': 'pode editar'}
        ]).get();
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

    return _listaProjetos;
  }

  Future sincronizaListaProjects(String tipoProjeto) async {
    _listaProjetos.clear();
    return readProjects(tipoProjeto);
  }

  saveProjetoALl(List<ProjectModel> projectModel) {
    int i = 1;
    projectModel.forEach((project) async {
      print(i.toString());
      await db
          .collection('projetosPrincipais')
          .doc(project.idProjeto.toString())
          .set(project.toJson());
      if (!_listaProjetos
          .any((atual) => atual.idProjeto == project.idProjeto)) {
        _listaProjetos.add(project);
        print('$i-.1');
        await db
            .collection(
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
      proprietario: auth.id.value,
      tipoProj: 'privado',
      acl: [],
    );

    _listaProjetos.add(newProject);

    await reference.set(newProject.toJson());
  }

  void atualizaNomeProjeto(String idProj, String nomeAtualizado,
      {String idUsuario = 'idUsuario'}) async {
    String? tipo;

    int indice =
        _listaProjetos.indexWhere((element) => element.idProjeto == idProj);

    _listaProjetos.forEach((element) {
      if (element.idProjeto == idProj) {
        element.nome = nomeAtualizado;
      }
    });

    if (indice != -1) {
      _listaProjetos[indice].nome = nomeAtualizado;
      //tipo = _listaProjetos[indice].tipoProj;
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

  void remove(ProjectModel projeto, {String idUsuario = 'idProjeto'}) async {
    var reference = await db
        .collection("projetosPrincipais")
        .doc(projeto.idProjeto)
        .delete();
    _listaProjetos.remove(projeto);
  }

  void mudaTipoPermissaoProjeto(bool publico) {
    public.value = publico;
    print(public.value);
  }

  void tornaProjetoPublico(String idProjeto) async {
    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(idProjeto);

    String tipoProjeto = (public.value == true) ? "publico" : "privado";

    if (idProjeto != "") {
      int indice = _listaProjetos
          .indexWhere((element) => element.idProjeto == idProjeto);

      _listaProjetos.forEach((element) {
        if (element.idProjeto == idProjeto) {
          element.tipoProj = tipoProjeto;
        }
      });

      if (indice != -1) {
        _listaProjetos[indice].tipoProj = tipoProjeto;
        this.tipoProj.value = tipoProjeto;

        var reference =
            await db.collection('projetosPrincipais').doc(idProjeto);

        await reference.update({'tipoProj': tipoProjeto});
        debugPrint("Tornei o projeto Público");
      } else {
        debugPrint("Projeto não encontrado !");
      }
    } else {
      debugPrint("Erro ao tornar projeto público");
    }
  }

  atualizaTudo(String idProjeto) async {
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

  Paint criaPaintObjective({String? converteCor, Offset? c, double? diametro_Cinterno,}) {
    var r, g, b, a;
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

    Paint p = Paint()
      ..strokeWidth = 30
      ..color = Color.fromARGB(a, r, g, b) //RGBO(r, g, b, a)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..shader = RadialGradient(colors: [
        Color.fromARGB(a, r, g, b).withAlpha(200),
        Color.fromARGB(a, r, g, b),
      ], stops: [
        0.97,
        1
      ]).createShader(Rect.fromCenter(
          center: c!,
          width: diametro_Cinterno!,
          height: diametro_Cinterno!)
      );
    return p;
  }

  //==============================================CRUD MANDALA========================================================
  void atualizaObjetivoMandala(
    String idObjetivo, {
    String? nomeObjetivo,
    int? importancia,
    double? progresso,
    double? metaObj = 0.0,
    double? realizado = 0.0,
    String? arquivo,
    String? cor = "255-242-242-242",
  }) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);

    if (indice != -1) {
      if (nomeObjetivo != null) {
        _listObjects[indice].nome = nomeObjetivo;
        var reference =
            await db.collection('projetosPrincipais').doc(this.idProjeto.value);

        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }
      if (progresso != null) {
        _listObjects[indice].progresso = progresso;
        var reference =
            await db.collection('projetosPrincipais').doc(this.idProjeto.value);

        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }
      if (arquivo != null) {
        _listObjects[indice].arquivos!.add(arquivo);
        var reference =
            await db.collection('projetosPrincipais').doc(this.idProjeto.value);

        var l = _listObjects.map((v) => v.toJson()).toList();

        await reference.update({'objetivosPrincipais': l});
      }

      if (cor != null) {
        var reference =
            await db.collection('projetosPrincipais').doc(this.idProjeto.value);

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
  mudarAtivo(bool ativo, String idDoCara) {
    var reference = db.collection('usuarios').doc(idDoCara);

    (ativo)
        ? reference.update({'ativo': false})
        : reference.update({'ativo': true});
  }

  mudarEdit(bool editor, String idDoCara) {
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

  void atualizarNome(String nomeAtualizado) {
    if (ultimoNivelClicado.value == 2) {
      atualizaObjetivoMandala(ultimoObjetivoClicado.value,
          nomeObjetivo: nomeAtualizado);
    } else if (ultimoNivelClicado.value == 3) {
      atualizaResultado(ultimoResultadoClicado.value,
          nomeResultado: nomeAtualizado);
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

  gerarProgressoGeral(double realizado1, double realizado2, double realizado3,
      double realizado4, double meta1, double meta2, double meta3, double meta4,
      {bool grafico = false}) {
    if (meta1 + meta2 + meta3 + meta4 != 0) {
      double progresso = ((realizado1 + realizado2 + realizado3 + realizado4) /
              (meta1 + meta2 + meta3 + meta4)) *
          100;
      if (grafico == false) {
        return double.parse(progresso.toStringAsFixed(2));
      } else {
        return progresso.toInt();
      }
    } else {
      return 0;
    }
  }

  gerarProgresso(double realizado, double meta, {bool grafico = false}) {
    if (meta != 0) {
      double progresso = (realizado / meta) * 100;
      if (grafico == false) {
        return double.parse(progresso.toStringAsFixed(2));
      } else {
        return progresso.toInt();
      }
    } else {
      return 0.0;
    }
  }

  ocultaCriarProjeto(String tipo) {
    if (tipo == 'cliente' && filtragem.value != "privado") {
      botaoProjeto.value = false;
    } else {
      (tipo == 'cliente')
          ? (_listaProjetos
                      .where((element) =>
                          element.proprietario == auth.id.value)
                      .length ==
                  0)
              ? botaoProjeto.value = true
              : botaoProjeto.value = false
          : botaoProjeto.value = true;
    }

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

  adicionarExtensao(String nomeExtensao) async {
    if (ultimoNivelClicado.value == 3) {
      if (_listResults[indiceResult.value].extensao!.contains(nomeExtensao) ==
          false) {
        _listResults[indiceResult.value].extensao!.add(nomeExtensao);
      } else {}
    }
    if (ultimoNivelClicado.value == 2) {
      if (_listObjects[indiceObjective.value]
              .extensao!
              .contains(nomeExtensao) ==
          false) {
        _listObjects[indiceObjective.value].extensao!.add(nomeExtensao);
      } else {}
    }
    DocumentReference reference =
        db.collection('projetosPrincipais').doc(this.idProjeto.value);

    var lr = _listResults.map((v) => v.toJson()).toList();
    var lo = _listObjects.map((v) => v.toJson()).toList();

    await reference
        .update({'resultadosPrincipais': lr, 'objetivosPrincipais': lo});
  }

  removeExtensao(String extensao) async {
    if (ultimoNivelClicado.value == 3) {
      _listResults[indiceResult.value].extensao!.remove(extensao);
    }
    if (ultimoNivelClicado.value == 2) {
      _listObjects[indiceObjective.value].extensao!.remove(extensao);
    }
    DocumentReference reference =
        db.collection('projetosPrincipais').doc(this.idProjeto.value);

    var lr = _listResults.map((v) => v.toJson()).toList();
    var lo = _listObjects.map((v) => v.toJson()).toList();

    await reference
        .update({'resultadosPrincipais': lr, 'objetivosPrincipais': lo});
  }

  removeResponsavelPedaco(String nome, String email) async {
    if (ultimoNivelClicado.value == 3) {
      _listResults[indiceResult.value].donoResultado!.remove(nome);
      _listResults[indiceResult.value].donoResultado!.remove(email);
      for (var metric in _metricasFiltradas) {
        var indice = _listMetrics
            .indexWhere((element) => element.idMetrica == metric.idMetrica);
        _listMetrics[indice].donos!.remove(email);
      }
    }
    if (ultimoNivelClicado.value == 2) {
      _listObjects[indiceObjective.value].donos!.remove(nome);
      _listObjects[indiceObjective.value].donos!.remove(email);
    }
    DocumentReference reference =
        db.collection('projetosPrincipais').doc(this.idProjeto.value);

    var lr = _listResults.map((v) => v.toJson()).toList();
    var lo = _listObjects.map((v) => v.toJson()).toList();
    var lm = _listMetrics.map((v) => v.toJson()).toList();

    await reference
        .update({'resultadosPrincipais': lr, 'objetivosPrincipais': lo,  'metricasPrincipais': lm}); //[l]
  }

  String adicionarResponsavel(String? nomeResponsavel) {
    List<String> spli = [""];

    if (nomeResponsavel != "" && nomeResponsavel != null) {
      if (nomeResponsavel.contains("@")) {
        debugPrint("Adicionando responsável - $nomeResponsavel ");
        spli = nomeResponsavel.split("@");
      }
    } else {
      debugPrint("Nenhum responsável válido foi adicionado !");
    }
    responsaveis.value = spli[0];
    return spli[0];
  }

  void buscarResponsavel() {}

  void setStartAngle(int o, double anguloInicio) {
    _listObjects[o].setStartAngle(anguloInicio);
  }

  void setSweepAngle(int o, double sweep) {
    _listObjects[o].setSweepAngle(sweep);
  }

//======================= CRUD ACL =====================================

  UnmodifiableListView<ACL> get listaACLs => UnmodifiableListView(_listAcl);

  changePermissaoCompartilhar(String permissao) {
    this.permissaoCompartilhar.value = permissao;
  }

  atualizaACL(
      String idProjeto, String identificadorEmail, String permissao) async {
    var listAcl;

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(idProjeto);

    if (idProjeto != "") {
      int indice = _listaProjetos
          .indexWhere((element) => element.idProjeto == idProjeto);

      if (indice != -1) {
        var listaACL = _listaProjetos[indice].acl;
        bool jaEstaNaLista = false;
        bool mudouPermissao = false;
        int indiceAcl = -1;

        if (_listaProjetos[indice].acl != null) {
          if (_listaProjetos[indice].acl!.length > 0) {
            for (int a = 0; a < _listaProjetos[indice].acl!.length; a++) {
              var acl = _listaProjetos[indice].acl![a];

              if (acl.identificador == identificadorEmail) {
                jaEstaNaLista = true;
                if (acl.permissao != permissao) {
                  mudouPermissao = true;
                  indiceAcl = a;
                }
              }
            }
          } else if (_listaProjetos[indice].acl!.length == 0) {}
          if (jaEstaNaLista == false) {
            ACL aclObject =
                ACL(identificador: identificadorEmail, permissao: permissao);
            _listaProjetos[indice].acl!.add(aclObject);
            _listAcl.add(aclObject);
            listAcl = _listAcl.map((v) => v.toJson()).toList();
            await reference.update({'acl': listAcl});
          }
          if (jaEstaNaLista && mudouPermissao) {
            if (indiceAcl != -1) {
              _listaProjetos[indice].acl![indiceAcl].permissao = permissao;
              _listAcl[indiceAcl].permissao = permissao;
              listAcl = _listAcl.map((v) => v.toJson()).toList();
              await reference.update({'acl': listAcl});
            }
          }
          _listAcl.forEach((element) {
            print(element);
          });
        } else {
          debugPrint("lista ACL é igual a null");
        }
      } else {
        debugPrint("Projeto não encontrado !");
      }
    } else {
      debugPrint("Erro ao manipular ACLs");
    }
  }

  removerACL(
      String idProjeto, String identificadorEmail, String permissao) async {
    //var listAcl;
    var val = <Map<String, dynamic>>[];
    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(idProjeto);

    if (idProjeto != "") {
      int indice = _listaProjetos
          .indexWhere((element) => element.idProjeto == idProjeto);
      if (indice != -1) {
        var vinculo = _listaProjetos[indice]
            .acl!
            .where((element) => element.identificador == identificadorEmail);
        var vinculo2 = _listAcl
            .where((element) => element.identificador == identificadorEmail);

        for (var acl in vinculo2) {
          val.add(acl.toJson());
        }

        await reference.update({
          "acl": FieldValue.arrayRemove(val),
        }).then((_) {
          debugPrint(" Success ao remover ACL!");
        });

        _listaProjetos[indice].acl!.removeWhere(
            (element) => element.identificador == identificadorEmail);
        _listAcl.removeWhere(
            (element) => element.identificador == identificadorEmail);
        // var lacl = _listAcl.map((v) => v.toJson()).toList();
        // await reference
        //     .update({'acl': lacl});
      } else {
        debugPrint("Projeto e índice não encontrado, para remover o ACL");
      }
    } else {
      debugPrint("Erro ao remover um ACL. Não encontrei o projeto");
    }
  }

  addResponsavelPedaco(String nome, String email) async {
    if (ultimoNivelClicado.value == 3) {
      if (_listResults[indiceResult.value].donoResultado!.contains(nome) ==
              false &&
          _listResults[indiceResult.value].donoResultado!.contains(email) ==
              false) {
        _listResults[indiceResult.value].donoResultado!.add(nome);
        _listResults[indiceResult.value].donoResultado!.add(email);
        for (var metric in _responsaveisMetricas) {
          var indice = _listMetrics
              .indexWhere((element) => element.idMetrica == metric.idMetrica);
          _listMetrics[indice].donos!.add(email);
        }
      } else {
        for (var metric in _responsaveisMetricas) {
          var indice = _listMetrics
              .indexWhere((element) => element.idMetrica == metric.idMetrica);
          if (_listMetrics[indice].donos!.contains(email) == false) {
            _listMetrics[indice].donos!.add(email);
          }
        }
      }
    }
    if (ultimoNivelClicado.value == 2) {
      if (_listObjects[indiceObjective.value].donos!.contains(nome) == false &&
          _listObjects[indiceObjective.value].donos!.contains(email) == false) {
        _listObjects[indiceObjective.value].donos!.add(nome);
        _listObjects[indiceObjective.value].donos!.add(email);
      } else {}
    }
    DocumentReference reference =
        db.collection('projetosPrincipais').doc(this.idProjeto.value);

    var lr = _listResults.map((v) => v.toJson()).toList();
    var lo = _listObjects.map((v) => v.toJson()).toList();
    var lm = _listMetrics.map((v) => v.toJson()).toList();

    await reference
        .update({'resultadosPrincipais': lr, 'objetivosPrincipais': lo, 'metricasPrincipais': lm}); //[l]
  }

  acl() async {
    DocumentSnapshot us = await DBFirestore.get()
        .collection("usuarios")
        .doc("${auth.id.value}")
        .get();

    bool somenteLeitura = us.get('editor');

    var indice = _listAcl
        .indexWhere((element) => element.identificador == auth.email.value);

    if (indice != -1) {
      if (_listAcl[indice].permissao == 'pode editar') {
        editor.value = true;
      } else {
        editor.value = false;
      }
    } else {
      if (auth.id.value == proprietario.string) {
        if (somenteLeitura == false) {
          editor.value = false;
        } else {
          editor.value = true;
        }
      } else {
        debugPrint("Não encontrei projeto com ACL");
        editor.value = false;
      }
    }

    return editor.value;
  }

  void selecionarImagem() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    //     .then((value) {
    //   print(value!.names[0]);
    //   _nomeArquivoSelecionado.value = value.names[0]!;
    //   print(_nomeArquivoSelecionado.string);
    // });

    //Recuperar arquivo
    tipoArquivo = resultado!.files.single.extension;
    _arquivoImagemSelecionado = resultado.files.single.bytes;

  }

  void uploadImagem(String? usuario) {
    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
    FirebaseStorage _storage = FirebaseStorage.instance;
    var imageId = Uuid();

    if (arquivoSelecionado != null) {
      Reference imagePerfilRef = _storage.ref(
          "dados_usuarios/$usuario/projetos/${nome.value}/images/${imageId.v4()}.$tipoArquivo");

      UploadTask uploadtask = imagePerfilRef.putData(arquivoSelecionado);

      uploadtask.snapshotEvents.listen((TaskSnapshot snapshot) async{
        if(snapshot.state == TaskState.running){
          uploading.value = true;
          total.value = (snapshot.bytesTransferred/snapshot.totalBytes) * 100;
          print("Uploading: ${uploading.value}");
          print("Total: ${total.value}");
        }else if(snapshot.state == TaskState.success){
          uploading.value = false;
        }
      });


      uploadtask.whenComplete(() async {
        String urlImagem = await uploadtask.snapshot.ref.getDownloadURL();
        debugPrint("deu certo taí o link $urlImagem!!!");

        if (ultimoNivelClicado.value == 3) {
          atualizaResultado(ultimoResultadoClicado.value, arquivo: urlImagem);
        }
        if (ultimoNivelClicado.value == 2) {
          atualizaObjetivoMandala(ultimoObjetivoClicado.value,
              arquivo: urlImagem);
        }
      });
    } else {}
  }

  void selecionarPDF() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    //Recuperar arquivo
    tipoArquivo = resultado!.files.single.extension;
    _arquivoImagemSelecionado = resultado.files.single.bytes;
  }

  void uploadPDF(String? usuario) {
    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
    FirebaseStorage _storage = FirebaseStorage.instance;
    var pdfId = Uuid();

    if (arquivoSelecionado != null) {
      Reference imagePerfilRef = _storage.ref(
          "dados_usuarios/$usuario/projetos/${nome.value}/documents/${pdfId.v4()}.$tipoArquivo");

      //UploadTask deletetask = _storage.ref("dados_usuarios/$usuario/projetos/${nome.value}/documents/arquivoClicado").delete();

      UploadTask uploadtask = imagePerfilRef.putData(arquivoSelecionado);
      uploadtask.whenComplete(() async {
        String urlPDF = await uploadtask.snapshot.ref.getDownloadURL();
        debugPrint("deu certo taí o link $urlPDF!!!");

        if (ultimoNivelClicado.value == 3) {
          atualizaResultado(ultimoResultadoClicado.value, arquivo: urlPDF);
        }
        if (ultimoNivelClicado.value == 2) {
          atualizaObjetivoMandala(ultimoObjetivoClicado.value, arquivo: urlPDF);
        }
        return uploadtask;
      });

    } else {}
  }

  Future<void> baixarAnexo(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {
      debugPrint('Não é possivel fazer o download');
    }
  }

  realizadosDono(double? periodoAtual, String? emailDono) {
    final vinculoMetric =
    _listMetrics.where((element) => element.donos!.contains(emailDono));
    final vinculoObj =
    _listObjects.where((element) => element.donos!.contains(emailDono));

    double realizadoResult = 0;
    double realizado1 = 0;
    double realizado2 = 0;
    double realizado3 = 0;
    double realizado4 = 0;

    for (final vin in vinculoMetric) {
      print(vin.nomeMetrica);
      realizadoResult +=
          vin.realizado1! + vin.realizado2! + vin.realizado3! + vin.realizado4!;
      realizado1 += vin.realizado1!;
      realizado2 += vin.realizado2!;
      realizado3 += vin.realizado3!;
      realizado4 += vin.realizado4!;
    }
    for (final vin in vinculoObj) {
      realizadoResult += realizadoObjetivos(0.0, vin.idObjetivo!);
      realizado1 += realizadoObjetivos(1.0, vin.idObjetivo!);
      realizado2 += realizadoObjetivos(2.0, vin.idObjetivo!);
      realizado3 += realizadoObjetivos(3.0, vin.idObjetivo!);
      realizado4 += realizadoObjetivos(4.0, vin.idObjetivo!);
    }

    if (periodoAtual == 0.0) {
      return realizadoResult;
    } else if (periodoAtual == 1.0) {
      return realizado1;
    } else if (periodoAtual == 2.0) {
      return realizado2;
    } else if (periodoAtual == 3.0) {
      return realizado3;
    } else if (periodoAtual == 4.0) {
      return realizado4;
    } else {
      return '\nGeral : $realizadoResult\n\nQuarter 1 : $realizado1\n\nQuarter 2 : $realizado2\n\nQuarter 3 : $realizado3\n\nQuarter 4 : $realizado4\n';
    }
  }

  metasDono(double? periodoAtual, String? emailDono) {
    final vinculoMetric =
    _listMetrics.where((element) => element.donos!.contains(emailDono));
    final vinculoObj =
    _listObjects.where((element) => element.donos!.contains(emailDono));

    double metasResult = 0;

    double metas1 = 0;
    double metas2 = 0;
    double metas3 = 0;
    double metas4 = 0;

    for (final vin in vinculoMetric) {
      print(vin.nomeMetrica);
      metasResult += vin.meta1! + vin.meta2! + vin.meta3! + vin.meta4!;
      metas1 += vin.meta1!;
      metas2 += vin.meta2!;
      metas3 += vin.meta3!;
      metas4 += vin.meta4!;
    }
    for (final vin in vinculoObj) {
      metasResult += metaObjetivos(0.0, vin.idObjetivo!);
      metas1 += metaObjetivos(1.0, vin.idObjetivo!);
      metas2 += metaObjetivos(2.0, vin.idObjetivo!);
      metas3 += metaObjetivos(3.0, vin.idObjetivo!);
      metas4 += metaObjetivos(4.0, vin.idObjetivo!);
    }

    if (periodoAtual == 0.0) {
      return metasResult;
    } else if (periodoAtual == 1.0) {
      return metas1;
    } else if (periodoAtual == 2.0) {
      return metas2;
    } else if (periodoAtual == 3.0) {
      return metas3;
    } else if (periodoAtual == 4.0) {
      return metas4;
    } else {
      return '\nGeral : $metasResult\n\nQuarter 1 : $metas1\n\nQuarter 2 : $metas2\n\nQuarter 3 : $metas3\n\nQuarter 4 : $metas4\n';
    }
  }

  UnmodifiableListView<MetricasPrincipais> get metricas =>
      UnmodifiableListView(_metricasFiltradas);

  filtrarMetricas() {
    var lm = _listMetrics.where(
            (element) => element.idResultado == ultimoResultadoClicado.value);

    if (proprietario.value == auth.id.value) {
      if (ultimoNivelClicado.value == 3) {
        for (var m in lm) {
          _metricasFiltradas.add(m);
        }
      } else if (ultimoNivelClicado.value == 2) {
        _metricasFiltradas.clear();
      }
    } else {
      if (ultimoNivelClicado.value == 3) {
        var metricResponsavel =
        lm.where((element) => element.donos!.contains(auth.email.string));
        for (var m in metricResponsavel) {
          _metricasFiltradas.add(m);
        }
      } else if (ultimoNivelClicado.value == 2) {
        _metricasFiltradas.clear();
      }
    }
  }

  esvaziarFiltragem() {
    _metricasFiltradas.clear();
  }

  UnmodifiableListView<MetricasPrincipais> get selecionadasMetric =>
      UnmodifiableListView(_responsaveisMetricas);

  limpaResponsaveisMetrica() {
    _responsaveisMetricas.clear();
  }

  addDonoMetrics(MetricasPrincipais metric) {
    _responsaveisMetricas.add(metric);
  }

  removeDonoMetrics(MetricasPrincipais metric) {
    _responsaveisMetricas.remove(metric);
  }

  limpaTudo() {
    _listaProjetos.clear();

    idProjeto.value = "";
    nome.value = "";
    proprietario.value = "";
    tipoProj.value = "";

    _listObjects.clear();

    _listDonos.clear();

    _listResults.clear();

    _listMetrics.clear();

    _listAcl.clear();
  }
}
