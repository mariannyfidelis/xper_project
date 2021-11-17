import 'package:get/get.dart';
import 'package:xper_brasil_projects/utils/paleta_cores.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import '/widgets/cliente_visualizador/objetivos/manipula_niveis.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controllerAuth = Get.find<AuthService>();
    TextEditingController busca = TextEditingController();

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.home),
              splashRadius: 16),
          SizedBox(width: 20),
          Text('Plataforma XPER - WebAppbar'),
          Expanded(child: Container()),
          ManipulaOKR(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, top: 18.0),
            child: Container(
              height: 25,
              width: 250,
              child: TextField(
                controller: busca,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 15,
                decoration: InputDecoration(
                  labelText: 'Pesquise Por Responsável ou Extensão',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () => buscaResponsavelOuExtensao(context, busca),
          icon: Icon(Icons.search),
        ),
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () {},
          icon: Icon(Icons.settings),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.minPositive, double.minPositive),
                  shadowColor: Colors.white54,
                  elevation: 12,
                  backgroundColor: Colors.red),
              onPressed: () {
                //FirebaseAuth.instance.signOut();
                controllerAuth.logout();
                //Get.offAll("/");
                Navigator.popAndPushNamed(context, "/");
              },
              child: Text(
                " Sair ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
        ),
      ],
    );
  }

  void buscaResponsavelOuExtensao(BuildContext context, TextEditingController busca) {
    var mandalaController = Get.find<ControllerProjetoRepository>();

    var results = mandalaController.listaResultados.where((element) =>
    element.donoResultado!.contains(busca.text) ||
        element.extensao!.contains(busca.text.trim().toLowerCase()));
    var objetives = mandalaController.listaObjectives.where((element) =>
    element.donos!.contains(busca.text) ||
        element.extensao!.contains(busca.text.trim().toLowerCase()));

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Resultados da busca"),
          content: Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Objetivos Principais'),
                  SingleChildScrollView(
                      child: Column(children: [
                        for (var i in objetives)
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0),
                              child: TextButton(
                                  onPressed: () {
                                    mandalaController
                                        .indiceObjective.value =
                                        mandalaController
                                            .listaObjectives
                                            .indexWhere((element) =>
                                        element.idObjetivo ==
                                            i.idObjetivo);
                                    mandalaController
                                        .nomeObjMandala.value = i.nome!;
                                    mandalaController
                                        .ultimoNivelClicado.value = 2;
                                    mandalaController
                                        .ultimoObjetivoClicado
                                        .value = i.idObjetivo!;

                                    mandalaController.gerarProgresso(
                                        mandalaController
                                            .realizadoObjetivos(
                                            0.0, i.idObjetivo!),
                                        mandalaController.metaObjetivos(
                                            0.0, i.idObjetivo!));
                                    mandalaController.progressoAtualObj.value =
                                        mandalaController.gerarProgresso(
                                            mandalaController
                                                .realizadoObjetivos(
                                                mandalaController
                                                    .periodo.value,
                                                i.idObjetivo!),
                                            mandalaController
                                                .metaObjetivos(
                                                mandalaController
                                                    .periodo.value,
                                                i.idObjetivo!));
                                    busca.text = '';
                                    Get.back();
                                  },
                                  child: Text('${i.nome}',
                                      style: TextStyle(
                                          color:
                                          PaletaCores.corPrimaria,
                                          fontSize: 15)))),
                      ])),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Resultados Principais'),
                  SingleChildScrollView(
                      child: Column(children: [
                        for (var i in results)
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, bottom: 8.0),
                              child: TextButton(
                                  onPressed: () {
                                    mandalaController
                                        .indiceResult.value =
                                        mandalaController
                                            .listaResultados
                                            .indexWhere((element) =>
                                        element.idResultado ==
                                            i.idResultado);
                                    mandalaController.nomeResultMandala
                                        .value = i.nomeResultado!;
                                    mandalaController
                                        .ultimoNivelClicado.value = 3;
                                    mandalaController
                                        .ultimoResultadoClicado
                                        .value = i.idResultado!;
                                    mandalaController.progressoAtualResult
                                        .value =
                                        mandalaController.gerarProgresso(
                                            mandalaController
                                                .realizadoResulMetric(
                                                mandalaController
                                                    .periodo.value,
                                                i.idResultado),
                                            mandalaController
                                                .metasResulMetric(
                                                mandalaController
                                                    .periodo.value,
                                                i.idResultado));
                                    mandalaController
                                        .progressoResult.value =
                                        mandalaController
                                            .gerarProgresso(
                                            i.realizado!, i.meta!);
                                    busca.text = '';
                                    Get.back();
                                  },
                                  child: Text('${i.nomeResultado}',
                                      style: TextStyle(
                                          color:
                                          PaletaCores.corPrimaria,
                                          fontSize: 15))))
                      ]))
                ],
              ),
            ),
          ),
        ));
  }
}
