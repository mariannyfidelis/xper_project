import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/utils/configuracoes_aplicacao.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaExtensoes extends StatefulWidget {
  const ManipulaExtensoes({Key? key}) : super(key: key);

  @override
  _ManipulaExtensoesState createState() => _ManipulaExtensoesState();
}

class _ManipulaExtensoesState extends State<ManipulaExtensoes> {
  TextEditingController extensaoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    return Obx(
      () => Visibility(
        visible: mandalaController.visivel.value,
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Extensões      ", style: estilo_teste),
                SizedBox(width: 20),
                Container(
                  width: 250,
                  child: TextField(
                    //enabled: mandalaController.acl(),
                    //enableInteractiveSelection: mandalaController.acl(),
                    style: estilo_teste,
                    controller: extensaoController,
                    textAlign: TextAlign.justify,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintStyle: estilo_teste,
                        hintText: "Adicione uma extensão",
                        focusColor: PaletaCores.textColor,
                        prefixIcon: Icon(
                          Icons.extension,
                          size: 20,
                          color: PaletaCores.textColor,
                        ),
                        suffixIcon: IconButton(
                            color: PaletaCores.textColor,
                            splashRadius: 16,
                            onPressed: () {
                              if (extensaoController.text.trim() != "") {
                                mandalaController.adicionarExtensao(
                                    extensaoController.text
                                        .trim()
                                        .toLowerCase());
                              }
                              extensaoController.text = "";
                            },
                            icon: Icon(Icons.add_box, size: 14)),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 32.0),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    maxLength: 450,
                    keyboardType: TextInputType.text,
                  ),
                ),
                IconButton(
                    color: PaletaCores.textColor,
                    splashRadius: 16,
                    onPressed: listarExtensoes,
                    icon: Icon(Icons.list_alt, size: 14))
              ],
            ),
          ),
        ),
      ),
    );
  }

  listarExtensoes() {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (ctx) => AlertDialog(
              title: Column(children: [
                Text(
                  "Extensões",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
              content: Container(
                height: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (mandalaController.ultimoNivelClicado.value == 2)
                        if (mandalaController
                                .listaObjectives[
                                    mandalaController.indiceObjective.value]
                                .extensao!
                                .length >
                            0)
                          for (int i = 0;
                              i <
                                  mandalaController
                                      .listaObjectives[mandalaController
                                          .indiceObjective.value]
                                      .extensao!
                                      .length;
                              i++)
                            Row(
                              children: [
                                Text(
                                    '${mandalaController.listaObjectives[mandalaController.indiceObjective.value].extensao![i]}',
                                    style: estiloTextoBotaoDropMenuButton),
                                Expanded(child: Container(width: 25)),
                                IconButton(
                                  color: PaletaCores.corPrimaria,
                                  splashRadius: 16,
                                  onPressed: () {
                                    mandalaController.removeExtensao(
                                        mandalaController
                                            .listaObjectives[mandalaController
                                                .indiceObjective.value]
                                            .extensao![i]);
                                  },
                                  icon: Icon(Icons.highlight_remove, size: 10),
                                )
                              ],
                            ),
                      if (mandalaController.ultimoNivelClicado.value == 3)
                        if (mandalaController
                                .listaResultados[
                                    mandalaController.indiceResult.value]
                                .extensao!
                                .length >
                            0)
                          for (int i = 0;
                              i <
                                  mandalaController
                                      .listaResultados[
                                          mandalaController.indiceResult.value]
                                      .extensao!
                                      .length;
                              i++)
                            Row(
                              children: [
                                Text(
                                    '${mandalaController.listaResultados[mandalaController.indiceResult.value].extensao![i]}',
                                    style: estiloTextoBotaoDropMenuButton),
                                Expanded(child: Container(width: 25)),
                                IconButton(
                                  color: PaletaCores.corPrimaria,
                                  splashRadius: 16,
                                  onPressed: () {
                                    mandalaController.removeExtensao(
                                        mandalaController
                                            .listaObjectives[mandalaController
                                                .indiceObjective.value]
                                            .extensao![i]);
                                  },
                                  icon: Icon(Icons.highlight_remove, size: 10),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
