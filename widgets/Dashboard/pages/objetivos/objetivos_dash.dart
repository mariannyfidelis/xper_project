import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ObjetivosTable extends StatefulWidget {
  const ObjetivosTable({Key? key}) : super(key: key);

  @override
  _ObjetivosTableState createState() => _ObjetivosTableState();
}

class _ObjetivosTableState extends State<ObjetivosTable> {
  TextEditingController novoObj = TextEditingController();
  TextEditingController idObj = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ControllerProjetoRepository listaObjetivosPrincipais =
        Get.find<ControllerProjetoRepository>();

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 6),
            color: PaletaCores.corLightGrey.withOpacity(.1),
            blurRadius: 12,
          ),
        ],
        border: Border.all(color: PaletaCores.corLightGrey, width: .5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Adicionar Objetivos",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(
            controller: novoObj,
            decoration: InputDecoration(
              //hintText: "Nome",
              labelText: "OKR definido",
              suffixIcon: Icon(Icons.grading),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, width: 10),
                adicionaBotao(1, "Adicionar objetivo", novoObj),
                SizedBox(width: 20),
                adicionaBotao(3, "Atualizar objetivo", novoObj,
                    atualiza: idObj.text),
                SizedBox(width: 20),
                adicionaBotao(2, "Sincronizar objetivos", novoObj),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                CustomText(
                  text: "Lista de Objetivos Principais",
                  color: PaletaCores.corLightGrey,
                  weight: FontWeight.bold,
                )
              ],
            ),
          ),
          Obx(
            () => DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(
                  label: Text(''),
                  size: ColumnSize.L,
                ),
              ],
              rows: List<DataRow>.generate(
                listaObjetivosPrincipais.listaObjectives.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                        //CustomText(text: controller.listObjects[index]),
                        Row(
                      children: [
                        Expanded(
                          child: CustomText(
                              text: listaObjetivosPrincipais
                                  .listaObjectives[index].nome),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                              color: Colors.blueGrey,
                              splashRadius: 20,
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                novoObj.text = listaObjetivosPrincipais
                                    .listaObjectives[index].nome
                                    .toString();
                                idObj.text = listaObjetivosPrincipais
                                    .listaObjectives[index].idObjetivo
                                    .toString();
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                              color: Colors.red,
                              splashRadius: 20,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                idObj.text = listaObjetivosPrincipais
                                    .listaObjectives[index].idObjetivo!;

                                showDialog(
                                    context: context,
                                    builder: (ctx) => buildAlertDialog());
                              }),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog buildAlertDialog() {
    return AlertDialog(
      title: Text("Excluir objetivo"),
      content: Text("Tem certeza ?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.find<ControllerProjetoRepository>()
                  .removeObjetivo("${idObj.text}");

              novoObj.text = '';
              Get.back();
            },
            child: Text("Sim")),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Não"))
      ],
    );
  }

  Widget adicionaBotao(
      int tipoOperacao, String textoBotao, TextEditingController novoObjetivo,
      {String atualiza = ""}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: PaletaCores.active, width: .5),
          color: PaletaCores.corLight,
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: PaletaCores.corLight,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
        ),
        onPressed: () {
          if (Get.find<ControllerProjetoRepository>().idProjeto.value != '') {
            if (tipoOperacao == 1) {
              Get.find<ControllerProjetoRepository>()
                  .addOneObjective(novoObjetivo.text);
              novoObjetivo.text = '';
            } else if (tipoOperacao == 2) {
              var controller = Get.find<ControllerProjetoRepository>();
              controller.atualizaTudo(controller.idProjeto.string);
            } else if (tipoOperacao == 3) {
              Get.find<ControllerProjetoRepository>()
                  .atualizaObjetivo(idObj.text, novoObj.text);
              novoObjetivo.text = '';
              idObj.text = '';
            } else {
              debugPrint("Operação inválida em Objetivos");
            }
          } else {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                        title: Text("Nenhum Projeto Selecionado"),
                        content: Text(
                            "Vá no menu projetos, selecione um projeto e tente novamente"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("OK")),
                        ]));
          }
        },
        child: CustomText(
          text: textoBotao,
          color: PaletaCores.active.withOpacity(.7),
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
