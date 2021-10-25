import 'dart:collection';
import 'package:get/get.dart';
import '/models/project_model.dart';
import '/database/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectsRepository2 extends GetxController {
  List<ProjectModel> _listaProjetos = <ProjectModel>[
    // ProjectModel(
    //     idProjeto: "123dadada",
    //     nome: "Marketing",
    //     proprietario: 'Marianny Fidelis',
    //     objetivosPrincipais: [],
    //     listaDonos: [],
    //     metricasPrincipais: [],
    //     resultadosPrincipais: [],
    //     acl: []),
    // ProjectModel(
    //     idProjeto: "2qweqw23133",
    //     nome: "Gestão de projetos",
    //     proprietario: 'Patrick Fidelis',
    //     objetivosPrincipais: [],
    //     listaDonos: [],
    //     metricasPrincipais: [
    // MetricasPrincipais(idMetrica: "idmetrica1", nomeMetrica: "Metrica1"),
    // MetricasPrincipais(idMetrica: "idmetrica2", nomeMetrica: "Metrica2"),
    // ],
    // resultadosPrincipais: [
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
    // ],
    // acl: [
    // ACL(idDonoResultadoMetrica: "123", permissao: "read"),
    // ACL(idDonoResultadoMetrica: "xxx", permissao: "write"),
    // ACL(idDonoResultadoMetrica: "555", permissao: "owner")
    //       ]),
  ].obs;
  late FirebaseFirestore db;

  ProjectsRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readProjects();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readProjects() async {
    //if (auth.usuario != null && _lista.isEmpty) {
    final snapshot = await db.collection(
        //'objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        'projetosPrincipais').get(); //verificar com snapshots

    for (var doc in snapshot.docs) {
      ProjectModel table = ProjectModel.fromJson(doc.data());
      _listaProjetos.add(table);
    }
    //}
  }

  sincronizaListaProjects() {
    _listaProjetos.clear();
    _readProjects();
  }

  UnmodifiableListView<ProjectModel> get listaProjetos => UnmodifiableListView(_listaProjetos);

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
      if (!_listaProjetos.any((atual) => atual.idProjeto == project.idProjeto)) {
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

  // saveOneProjeto(String idProjeto, String nomeProjeto, String emailDonoResultado) async {
  //   DocumentReference reference = await db
  //   //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
  //       .collection('projetosPrincipais')
  //   //.doc(objetivo.idObjetivo.toString());
  //       .doc();
  //
  //   ProjectModel projectModel = DonosResultadoMetricas(
  //       id: reference.id,
  //       nome: nomeDonoResultado,
  //       email: emailDonoResultado);
  //
  //   _lista.add(dono);
  //
  //   await reference.set({
  //     'id': dono.id,
  //     'nome': dono.nome,
  //     'email': dono.email,
  //   });
  // }
  //

  // TODO: substituir e colocar em um menu de um objetivo 3 pontinhos.
  remove(ProjectModel projeto) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('projetosPrincipais')
        .doc(projeto.idProjeto)
        .delete();
    _listaProjetos.remove(projeto);
  }

  removeProjeto(String idProjeto) async {
    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('projetosPrincipais')
        .doc(idProjeto)
        .delete();
    _listaProjetos.removeWhere((element) => element.idProjeto == idProjeto);
  }

  void atualizaProjeto(String idProjeto,
      {String? nomeNovoProjetoAtualizado,
      List? listaAtualizadaOobjetivos,
      List? listaAtualizadaDonos,
      List? listaAtualizadaMetricas,
      List? listaAtualizadaResultados,
      List? listaAtualizadaACL}) async {
    int indice = _listaProjetos.indexWhere((element) => element.idProjeto == idProjeto);
    if (nomeNovoProjetoAtualizado != null) {
      _listaProjetos[indice].nome = nomeNovoProjetoAtualizado;
    }
    //TODO: verificar a atualização de projetos e a implementação dos métodos atualiza
    if (listaAtualizadaOobjetivos != null &&
        listaAtualizadaOobjetivos.isNotEmpty)
      atualizaObjetivosProjeto(
          idProjeto, indice, _listaProjetos, listaAtualizadaOobjetivos);
    if (listaAtualizadaDonos != null && listaAtualizadaDonos.isNotEmpty)
      atualizaDonosProjeto(idProjeto, indice, _listaProjetos, listaAtualizadaDonos);
    if (listaAtualizadaMetricas != null && listaAtualizadaMetricas.isNotEmpty)
      atualizaMetricasProjeto(
          idProjeto, indice, _listaProjetos, listaAtualizadaMetricas);
    if (listaAtualizadaResultados != null &&
        listaAtualizadaResultados.isNotEmpty)
      atualizaResultadosProjeto(
          idProjeto, indice, _listaProjetos, listaAtualizadaResultados);
    if (listaAtualizadaACL != null && listaAtualizadaACL.isNotEmpty)
      atualizaACLProjeto(idProjeto, indice, _listaProjetos, listaAtualizadaACL);

    //TODO: Vamos supor ele atualiza a lista toda dentros dos IFs e agora é que
    // vai enviar em uma única requisição POST todos os dados. (mais eficiente)

    await db
        //.collection('objetivoUsuario/${auth.usuario!.uid}/objetivosPrincipais')
        .collection('projetosPrincipais')
        .doc(idProjeto)
        .update(_listaProjetos[indice].toJson()); //
    sincronizaListaProjects();
  }

  //TODO: implementar metodo atualizaObjetivosProjeto
  void atualizaObjetivosProjeto(String idProjeto, int indice,
      List<ProjectModel> lista, List listaAtualizadaOobjetivos) {}

  //TODO: implementar metodo atualizaDonosProjeto
  void atualizaDonosProjeto(String idProjeto, int indice,
      List<ProjectModel> lista, List listaAtualizadaDonos) {}

  //TODO: implementar metodo atualizaMetricasProjeto
  void atualizaMetricasProjeto(String idProjeto, int indice,
      List<ProjectModel> lista, List listaAtualizadaMetricas) {}

  //TODO: implementar metodo atualizaResultadosProjeto
  void atualizaResultadosProjeto(String idProjeto, int indice,
      List<ProjectModel> lista, List listaAtualizadaResultados) {}

  //TODO: implementar metodo atualizaACLProjeto
  void atualizaACLProjeto(String idProjeto, int indice,
      List<ProjectModel> lista, List listaAtualizadaACL) {}
}
