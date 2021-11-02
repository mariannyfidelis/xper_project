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

  int ultimoNivelClicado = 1;

  var ultimoObjetivoClicado = "".obs;
  var ultimoResultadoClicado = "".obs;
  //String ultimoMetricaClicada = "";

  var idProjeto = "".obs;
  var nome = "".obs;
  var proprietario = "".obs;
  var tipoProj = "".obs;

  List<ObjetivosPrincipais> _listObjects = <ObjetivosPrincipais>[
    // ObjetivosPrincipais(
    //     idObjetivo: "idObjetivo",
    //     nome: "nome",
    //     progresso: 100,
    //     importancia: 100),
    // ObjetivosPrincipais(
    //     idObjetivo: "idObjetivo2",
    //     nome: "nome2",
    //     progresso: 100,
    //     importancia: 100)
  ].obs;

  List<DonosResultadoMetricas> _listDonos = <DonosResultadoMetricas>[
    // DonosResultadoMetricas(
    //   id: "1",
    //   nome: 'Marianny Fidelis',
    //   email: "mariannyfidelis@hotmail",
    // )
  ].obs;

  List<ResultadosPrincipais> _listResults = <ResultadosPrincipais>[
    // ResultadosPrincipais(
    //   idResultado: "idResultado1",
    //   nomeResultado: "Resultado1",
    //   idObjetivoPai: "idobj1",
    //   donoResultado: ["donoResultado1", "dono2"],
    // ),
    // ResultadosPrincipais(
    //     idResultado: "idResultado1",
    //     nomeResultado: "Resultado1",
    //     idObjetivoPai: "idobj1",
    //     donoResultado: ["donoResultado1", "dono2"])
  ].obs;

  List<MetricasPrincipais> _listMetrics = <MetricasPrincipais>[
    // MetricasPrincipais(idMetrica: "idmetrica1", nomeMetrica: "Metrica1"),
    // MetricasPrincipais(idMetrica: "idmetrica2", nomeMetrica: "Metrica2"),
  ].obs;

  List<ACL> _listAcl = <ACL>[
    // ACL(idDonoResultadoMetrica: "123", permissao: "read"),
    // ACL(idDonoResultadoMetrica: "xxx", permissao: "write"),
    // ACL(idDonoResultadoMetrica: "555", permissao: "owner")
  ].obs;

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
      {int importancia = 100, int progresso = 100}) async {
    var uuid = Uuid();

    DocumentReference reference =
        await db.collection('projetosPrincipais').doc(this.idProjeto.value);

    ObjetivosPrincipais objetivo = ObjetivosPrincipais(
      idObjetivo: uuid.v4(),
      importancia: importancia,
      nome: nomeObjetivo,
      progresso: progresso,
      startAngle: 0,
      sweepAngle: 360,
    );

    _listObjects.add(objetivo);

    var l = _listObjects.map((v) => v.toJson()).toList();

    await reference.update({'objetivosPrincipais': l}); //[l]
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

    if (indice != -1) {
      print(_listObjects[indice]);
      var a = _listObjects.removeAt(indice);
      val.add(a.toJson());

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      reference.update(
          {"objetivosPrincipais": FieldValue.arrayRemove(val)}).then((_) {
        print("success com projeto repository!");
      });
    } else {
      debugPrint("Não encontrei o objetivo !");
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
        // idMetrica: idMetrica,
        donoResultado: (donos != null)
            ? (donos.isEmpty)
                ? []
                : donos
            : []);

    _listResults.add(resultadosPrincipais);

    var l = _listResults.map((v) => v.toJson()).toList();

    await reference.update({'resultadosPrincipais': l}); //[l]
  }

  void removeResultado(String idResultado) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listResults[indice]);
      var a = _listResults.removeAt(indice);
      val.add(a.toJson());

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      reference.update(
          {"resultadosPrincipais": FieldValue.arrayRemove(val)}).then((_) {
        print("success com a remoção de resultado do projeto repository!");
      });
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

  void atualizaResultado(String idResultado, String nomeResultaAtualizado,
      {String? idObjetivoPai,
      String? idMetrica = "",
      List<DonosResultadoMetricas>? dono}) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    if (indice != -1) {
      _listResults[indice].nomeResultado = nomeResultaAtualizado;
      _listResults[indice].idObjetivoPai = idObjetivoPai;
      // _listResults[indice].idMetrica = idMetrica;

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

  void travarMeta(String idMetrica, double metaTravada) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].meta = metaTravada;

      var reference =
          await db.collection('projetosPrincipais').doc(this.idProjeto.value);

      var l = _listMetrics.map((v) => v.toJson()).toList();

      await reference.update({'metricasPrincipais': l});

      atualizaTudo(this.idProjeto.value);
    } else {
      print("Métrica não encontrada !");
    }
  }

  void atualizarRealizado(String idMetrica, double realizado) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].realizado = realizado;

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
            .where('tipoProj', isEqualTo: tipo)
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
    //_listaProjetos.reactive;
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

  Paint criaPaintObjective() {
    var r = Random().nextInt(40) + 215;
    var g = Random().nextInt(40) + 215;
    var b = Random().nextInt(40) + 215;

    //TODO - Como colocar sombra e elevação
    Paint p = Paint()
      ..strokeWidth = 30
      ..color = Color.fromRGBO(r, g, b, 1)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;
    return p;
  }
}
