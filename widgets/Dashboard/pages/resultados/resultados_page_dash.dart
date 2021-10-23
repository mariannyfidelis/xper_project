import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/models/objetivosPrincipaisModel.dart';
import '/models/donoResultadoMetricaModel.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ResultadosTable extends StatefulWidget {
  const ResultadosTable({Key? key}) : super(key: key);

  @override
  _ResultadosTableState createState() => _ResultadosTableState();
}

class _ResultadosTableState extends State<ResultadosTable> {
  TextEditingController newResultadoController = TextEditingController();
  TextEditingController idResultadoController = TextEditingController();
  String idProjeto = "2qweqw23133";

  @override
  Widget build(BuildContext context) {
    var controllerProjeto = Get.find<ControllerProjetoRepository>();
    var objetivosController = controllerProjeto.listaObjectives;

    ObjetivosPrincipais? selectedValue;
    if (controllerProjeto.listaObjectives.isNotEmpty) {
      setState(() {
        selectedValue = controllerProjeto.listaObjectives[0];
      });
    } else {
      setState(() {
        selectedValue = null;
      });
    }

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: PaletaCores.corLightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: PaletaCores.corLightGrey, width: .5)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              text: "Adicionar Resultados",
              color: PaletaCores.corLightGrey,
              weight: FontWeight.bold),
          TextField(
            controller: newResultadoController,
            decoration: InputDecoration(
              labelText: "OKR definido",
              suffixIcon: Icon(Icons.grading),
            ),
          ),
          SizedBox(height: 40, width: 10),
          CustomText(
              text: "O resultado pertence a qual objetivo ?",
              color: PaletaCores.corLightGrey,
              weight: FontWeight.bold),
          SizedBox(height: 20, width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0), //selectedValue != null ?
            child: DropdownButton<ObjetivosPrincipais>(
              value: selectedValue,
              onChanged: (value) {
                setState(() {
                  //selectedValue = value as ObjetivosPrincipais;
                  selectedValue = value!;
                });
              },
              items: objetivosController.map((ObjetivosPrincipais objetivo) {
                return new DropdownMenuItem<ObjetivosPrincipais>(
                  child: Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(5.0)),
                      height: 50.0,
                      width: 600,
                      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                      child: new Text(objetivo.nome.toString()),
                    ),
                  ),
                  value: objetivo,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 30, width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, width: 10),
                adicionaBotao(1, "Adicionar resultado principal"),
                SizedBox(width: 20),
                adicionaBotao(3, "Atualizar resultado"),
                SizedBox(width: 20),
                adicionaBotao(2, "Sincronizar os resultados"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                CustomText(
                  text: "Resultados Principais do Projeto",
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
                )
              ],
              rows: List<DataRow>.generate(
                controllerProjeto.listaResultados.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      //CustomText(text: controller.listResults[index]),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                                text: controllerProjeto
                                    .listaResultados[index].nomeResultado),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                color: Colors.blueGrey,
                                splashRadius: 20,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  newResultadoController.text =
                                      controllerProjeto
                                          .listaResultados[index].nomeResultado
                                          .toString();

                                  idResultadoController.text = controllerProjeto
                                      .listaResultados[index].idResultado
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
                                  idResultadoController.text = controllerProjeto
                                      .listaResultados[index].idResultado!;
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => buildAlertDialog(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
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
      title: Text("Excluir resultado"),
      content: Text("Tem certeza ?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.find<ControllerProjetoRepository>()
                  .removeResultado(idProjeto, idResultadoController.text);
              newResultadoController.text = '';
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

  adicionaBotao(int operacao, String textoBotao) {
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
          var resultadoController2 = Get.find<ControllerProjetoRepository>();
          //TODO: Corrigir para pegar os dados de Donos e Objetivos Pai
          //var donoController = Get.find<ControllerProjetoRepository>().listaDonos;
          //var objetivoController = Get.find<ControllerProjetoRepository>().listaObjectives;

          if (operacao == 1) {
            //TODO: Aqui será feito o link entre Objetivos Resultados e Donos
            var idObjetivoPai = "";
            var donos = <DonosResultadoMetricas>[];

            resultadoController2.addOneResultado(
                idProjeto, newResultadoController.text,
                idObjetivoPai: idObjetivoPai, donos: donos);

            newResultadoController.text = "";
            //objetivoPaiController.text = "";
          } else if (operacao == 2) {
            resultadoController2.sincronizaListaResultados();
          } else if (operacao == 3) {
            resultadoController2.atualizaResultado(idProjeto,
                idResultadoController.text, newResultadoController.text);

            idResultadoController.text = '';
            newResultadoController.text = '';
          } else {
            debugPrint("Operação inválida em resultados principais");
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
