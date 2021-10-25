import 'dart:core';
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
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

MenuControllerDash menuControllerDash = MenuControllerDash.instance;
NavigationControllerDash navigationController =
    NavigationControllerDash.instance;

//TODO: Como verificar e recuperar o usuário que está autenticado
var auth = Get.find<AuthService>();
String idUsuario = auth.usuario!.uid; //'5xmMnHGksrPtVK4rvnEsoYSemrr2';
//String idProjeto2 = "2qweqw23133"; //não está sendo usado

class ControllerProjetoRepository extends GetxController {
  //var pModelTeste = <ProjectModel>ProjectModel().obs;
  List<ProjectModel> _listaProjetos = <ProjectModel>[].obs;

  var idProjeto = "".obs;
  var nome = "".obs;
  var proprietario = "".obs;

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

    if (listaProjetos.isNotEmpty) {
      await _readProjeto(_listaProjetos
          .elementAt(_listaProjetos.length - 1)
          .idProjeto
          .toString());
    }
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readProjeto(String idProjeto,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db
        .collection('usuarios/$idUsuario/projetos')
        .doc(idProjeto)
        .get();

    print(snapshot.data());
    late ProjectModel proj;
    if (snapshot.data() != null) {
      proj = ProjectModel.fromJson(snapshot.data()!);
    }

    //TODO: Erro em converter RxString para String
    //idProjeto = proj.idProjeto! as RxString;
    //nome = proj.nome! as RxString;
    //proprietario = proj.proprietario! as RxString;

    //listObjects = proj.objetivosPrincipais!;
    _listObjects.clear();
    proj.objetivosPrincipais!.forEach((element) {
      _listObjects.add(element);
      print("${element.nome} - ");
    });

    //listResults = proj.resultadosPrincipais!;
    _listResults.clear();
    proj.resultadosPrincipais!.forEach((element) {
      _listResults.add(element);
      print("${element.nomeResultado} - ");
    });

    //listDonos = proj.listaDonos!;
    _listDonos.clear();
    proj.listaDonos!.forEach((element) {
      _listDonos.add(element);
      print("${element.nome} - ");
    });

    //listMetrics = proj.metricasPrincipais!;
    _listMetrics.clear();
    proj.metricasPrincipais!.forEach((element) {
      _listMetrics.add(element);
      print("${element.nomeMetrica} - ");
    });

    //listAcl = proj.acl!;
    _listAcl.clear();
    proj.acl!.forEach((element) {
      _listAcl.add(element);
    });
    print("${_listObjects.length} ${_listDonos.length}");
    //TODO: Erro
    //print("$idProjeto  $nome  $proprietario");
    //}
  }

  //======================= CRUD objetivos =====================================
  UnmodifiableListView<ObjetivosPrincipais> get listaObjectives =>
      UnmodifiableListView(_listObjects);

  void addOneObjective(String idProjeto, String nomeObjetivo,
      {int importancia = 100, int progresso = 100}) async {
    var uuid = Uuid();

    DocumentReference reference =
        await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);

    ObjetivosPrincipais objetivo = ObjetivosPrincipais(
        idObjetivo: uuid.v4(),
        importancia: importancia,
        nome: nomeObjetivo,
        progresso: progresso);
    _listObjects.add(objetivo);

    var l = _listObjects.map((v) => v.toJson()).toList();

    await reference.update({'objetivosPrincipais': l}); //[l]
  }

  // TODO - sincroniza
  void sincronizaListaObjetivos() {
    _listObjects.clear();
    _readProjeto(idProjeto.value);
  }

  void atualizaObjetivo(
      String idProjeto, String idObjetivo, String nomeObjetivoAtualizado,
      {int importancia = 100, int progresso = 100}) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);

    if (indice != -1) {
      _listObjects[indice].nome = nomeObjetivoAtualizado;
      var reference = await db
          //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
          .collection('usuarios/$idUsuario/projetos')
          .doc(idProjeto);

      var l = _listObjects.map((v) => v.toJson()).toList();

      await reference.update({'objetivosPrincipais': l});

      sincronizaListaObjetivos();
    } else {
      print("Objetivo não encontrado !");
    }
  }

  removeObjetivo(String idProjeto, String idObjetivo) async {
    int indice =
        _listObjects.indexWhere((element) => element.idObjetivo == idObjetivo);
    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listObjects[indice]);
      var a = _listObjects.removeAt(indice);
      val.add(a.toJson());

      var reference = await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);

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

  void addOneResultado(String idProjeto, String nomeResultado,
      {String? idObjetivoPai = "idObjetivoPai",
      String idMetrica = "idMetrica",
      List<DonosResultadoMetricas?>? donos}) async {
    var uuid = Uuid();

    DocumentReference reference = await db
        .collection('usuarios/$idUsuario/projetos')
        .doc(idProjeto);

    ResultadosPrincipais resultadosPrincipais = ResultadosPrincipais(
        idResultado: uuid.v4(),
        nomeResultado: nomeResultado,
        idObjetivoPai: idObjetivoPai,
        idMetrica: idMetrica,
        donoResultado: (donos != null)
            ? (donos.isEmpty)
                ? []
                : donos
            : []);

    _listResults.add(resultadosPrincipais);

    var l = _listResults.map((v) => v.toJson()).toList();

    await reference.update({'resultadosPrincipais': l}); //[l]
  }

  void sincronizaListaResultados() {
    _listResults.clear();
    _readProjeto(idProjeto.value);
  }

  void removeResultado(String idProjeto, String idResultado) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listResults[indice]);
      //_listObjects.removeWhere((element) => element.idObjetivo == idObjetivo);
      var a = _listResults.removeAt(indice);
      val.add(a.toJson());
      //val.add(_listObjects.elementAt(indice));

      var reference = await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);

      reference.update(
          {"resultadosPrincipais": FieldValue.arrayRemove(val)}).then((_) {
        print("success com a remoção de resultado do projeto repository!");
      });
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

  void atualizaResultado(
      String idProjeto, String idResultado, String nomeResultaAtualizado,
      {String? idObjetivo, List<DonosResultadoMetricas>? dono}) async {
    int indice = _listResults
        .indexWhere((element) => element.idResultado == idResultado);

    if (indice != -1) {
      _listResults[indice].nomeResultado = nomeResultaAtualizado;
      _listResults[indice].nomeResultado = nomeResultaAtualizado;
      var reference = await db
          //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
          .collection('usuarios/$idUsuario/projetos')
          .doc(idProjeto);

      var l = _listResults.map((v) => v.toJson()).toList();

      await reference.update({'resultadosPrincipais': l});
      sincronizaListaResultados();
    } else {
      debugPrint("Não encontrei o resultado !");
    }
  }

//======================= CRUD donos =====================================

  UnmodifiableListView<DonosResultadoMetricas> get listaDonos =>
      UnmodifiableListView(_listDonos);

  void sincronizaListaDonos() {
    _listDonos.clear();
    _readProjeto(idProjeto.value);
  }

  void addOneDono(String idProjeto, String nomeDono, String emailDono) async {
    var uuid = Uuid();

    DocumentReference reference = await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('usuarios/$idUsuario/projetos')
        .doc(idProjeto);

    DonosResultadoMetricas dono =
        DonosResultadoMetricas(id: uuid.v4(), nome: nomeDono, email: emailDono);
    _listDonos.add(dono);

    var d = _listDonos.map((v) => v.toJson()).toList();

    await reference.update({'listaDonos': d}); //[l]
  }

  void atualizaDono(
      String idProjeto, String id, String nome, String email) async {
    int indice = _listDonos.indexWhere((element) => element.id == id);

    if (indice != -1) {
      _listDonos[indice].nome = nome;
      _listDonos[indice].email = email;

      var reference = await db
          //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
          .collection('usuarios/$idUsuario/projetos')
          .doc(idProjeto);

      var l = _listDonos.map((v) => v.toJson()).toList();

      await reference.update({'listaDonos': l});

      sincronizaListaObjetivos();
    } else {
      debugPrint("Não encontrei o dono !");
    }
  }

  removeDono(String idProjeto, String id) async {
    int indice = _listDonos.indexWhere((element) => element.id == id);
    var val2 = <DonosResultadoMetricas>[];
    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listDonos[indice]);
      var a = _listDonos.removeAt(indice);
      val.add(a.toJson());
      //val.add(_listObjects.elementAt(indice));

      var reference = await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);
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

  void sincronizaListaMetricas() {
    _listMetrics.clear();
    _readProjeto(idProjeto.value);
  }

  void addOneMetric(String idProjeto, String nomeAtualizadoMetrica,
      {double meta = 100, double realizado = 1, double progresso = 0}) async {
    var uuid = Uuid();

    DocumentReference reference = await db
        .collection('usuarios/$idUsuario/projetos')
        .doc(idProjeto);

    MetricasPrincipais metrica = MetricasPrincipais(
        idMetrica: uuid.v4(), nomeMetrica: nomeAtualizadoMetrica);

    _listMetrics.add(metrica);

    var l = _listMetrics.map((v) => v.toJson()).toList();

    await reference.update({'metricasPrincipais': l}); //[l]
  }

  void atualizaMetrica(
      String idProjeto, String idMetrica, String nomeMetricaAtualizado,
      {double? meta, double? realizado, double? progresso}) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    if (indice != -1) {
      _listMetrics[indice].nomeMetrica = nomeMetricaAtualizado;

      var reference = await db
          .collection('usuarios/$idUsuario/projetos')
          .doc(idProjeto);

      var l = _listMetrics.map((v) => v.toJson()).toList();

      await reference.update({'metricasPrincipais': l});

      sincronizaListaMetricas();
    } else {
      print("Métrica não encontrada !");
    }
  }

  removeMetrica(String idProjeto, String idMetrica) async {
    int indice =
        _listMetrics.indexWhere((element) => element.idMetrica == idMetrica);

    var val = <Map<String, dynamic>>[];

    if (indice != -1) {
      print(_listMetrics[indice]);
      var a = _listMetrics.removeAt(indice);
      val.add(a.toJson());

      var reference = await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);
      reference.update(
          {"metricasPrincipais": FieldValue.arrayRemove(val)}).then((_) {
        print("success com projeto repository!");
      });
    } else {
      debugPrint("Não encontrei a métrica !");
    }
  }

//========================== CRUD TODOS OS PROJETOS =====================================

  UnmodifiableListView<ProjectModel> get listaProjetos =>
      UnmodifiableListView(_listaProjetos);

  readProjects(String? tipo,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    if (tipo != "todos") {
      final snapshot = await db
          .collection('usuarios/$idUsuario/projetos')
          .where('tipoProj', isEqualTo: tipo)
          .get(); //verificar com snapshots

      //TODO: Tratar retorno nulo do SNAPSHOT !!!
      for (var doc in snapshot.docs) {
        ProjectModel table = ProjectModel.fromJson(doc.data());
        _listaProjetos.add(table);
      }
    } else {
      final snapshot = await db
          .collection('usuarios/$idUsuario/projetos')
          .get(); //verificar com snapshots
      //TODO: Tratar retorno nulo do SNAPSHOT !!!
      if (snapshot != null) {
        for (var doc in snapshot.docs) {
          ProjectModel table = ProjectModel.fromJson(doc.data());
          _listaProjetos.add(table);
        }
      }
    }
  }

  sincronizaListaProjects(String tipoProjeto, String idUsuario) {
    _listaProjetos.clear();
    readProjects(tipoProjeto, idUsuario: idUsuario);
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

  void addOneProject(String nome,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    var uuid = Uuid();
    String idProjeto = uuid.v4();

    DocumentReference reference =
        await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);

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

  void atualizaNomeProjeto(String idProjeto, String nomeAtualizado,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    // int indice =
    //     _listProjects.indexWhere((element) => element.idProject == idProject);

    // if (indice != -1) {
    //   _listObjects[indice].nome = nomeObjetivoAtualizado;
    var reference =
        await db.collection('usuarios/$idUsuario/projetos').doc(idProjeto);

    // var l = _listProjects.map((v) => v.toJson()).toList();

    await reference.update({'nome': nomeAtualizado});

    // } else {
    //   print("Objetivo não encontrado !");
    // }
  }

  void removeProjeto(String idProjeto, String idUsuario) async {
    var reference =
        await db.collection("usuarios/$idUsuario/projetos").doc(idProjeto);

    _listaProjetos.removeWhere((element) => element.idProjeto == idProjeto);
    reference.delete();
  }

  void remove(ProjectModel projeto,
      {String idUsuario = '5xmMnHGksrPtVK4rvnEsoYSemrr2'}) async {
    var reference = await db
        .collection("usuarios/$idUsuario/projetos")
        .doc(projeto.idProjeto)
        .delete();
    _listaProjetos.remove(projeto);
  }

  void atualizaTudo(String? idProjeto, int index) {
    _readProjeto(idProjeto!);

    //Quando eu termino eu tenho que atualizar todos os lists Objects, results, metrics
  }
}
