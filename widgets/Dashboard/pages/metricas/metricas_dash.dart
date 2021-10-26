import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/models/metricasModel.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class MetricasTable extends StatefulWidget {
  const MetricasTable({Key? key}) : super(key: key);

  @override
  _MetricasTableState createState() => _MetricasTableState();
}

class _MetricasTableState extends State<MetricasTable> {
  TextEditingController newMetrica = TextEditingController();
  TextEditingController idMetrica = TextEditingController();
  //String idProjeto = "2qweqw23133";

  @override
  Widget build(BuildContext context) {
    ControllerProjetoRepository controllerProjetoRepository =
        Get.find<ControllerProjetoRepository>();

    var metricasController = controllerProjetoRepository.listaMetricas;
    MetricasPrincipais? selectedValue;

    if (metricasController.isNotEmpty) {
      setState(() {
        selectedValue = metricasController[0];
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
              blurRadius: 12,
            ),
          ],
          border: Border.all(color: PaletaCores.corLightGrey, width: .5)),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Adicionar Metricas",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(
            controller: newMetrica,
            decoration: InputDecoration(
              labelText: "Métrica definida",
              suffixIcon: Icon(Icons.grading),
            ),
          ),
          SizedBox(height: 20, width: 10),
          SizedBox(height: 40, width: 10),
          CustomText(
              text: "A métrica pertence a qual resultado ?",
              color: PaletaCores.corLightGrey,
              weight: FontWeight.bold),
          SizedBox(height: 20, width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0), //selectedValue != null ?
            child: Obx(
              () => DropdownButton<MetricasPrincipais>(
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    //selectedValue = value as ObjetivosPrincipais;
                    selectedValue = value!;
                  });
                },
                items: metricasController.map((MetricasPrincipais metrica) {
                  return new DropdownMenuItem<MetricasPrincipais>(
                    child: Expanded(
                      child: Container(
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(5.0)),
                        height: 50.0,
                        width: 600,
                        padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                        child: new Text(metrica.nomeMetrica.toString()),
                      ),
                    ),
                    value: metrica,
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 30, width: 10),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20, width: 10),
                adicionaBotao(1, "Adicionar métricas"),
                SizedBox(width: 20),
                adicionaBotao(3, "Atualizar métrica"),
                SizedBox(
                  width: 20,
                ),
                adicionaBotao(2, "Sincronizar métricas"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Métricas",
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
                //controller.listMetrics.length,
                controllerProjetoRepository.listaMetricas.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      //CustomText(text: controller.listMetrics[index]),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                                text: controllerProjetoRepository
                                    .listaMetricas[index].nomeMetrica),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: IconButton(
                                color: Colors.blueGrey,
                                splashRadius: 20,
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  newMetrica.text = controllerProjetoRepository
                                      .listaMetricas[index].nomeMetrica
                                      .toString();
                                  idMetrica.text = controllerProjetoRepository
                                      .listaMetricas[index].idMetrica
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
                                  idMetrica.text = controllerProjetoRepository
                                      .listaMetricas[index].idMetrica!;
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
      title: Text("Excluir métrica"),
      content: Text("Tem certeza ?"),
      actions: [
        TextButton(
            onPressed: () {
              Get.find<ControllerProjetoRepository>()
                  .removeMetrica(idMetrica.text);
              newMetrica.text = '';
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
          var controlador = Get.find<ControllerProjetoRepository>();
          if (operacao == 1) {
            controlador.addOneMetric(newMetrica.text);
            newMetrica.text = "";
          } else if (operacao == 2) {
            controlador.atualizaTudo(controlador.idProjeto.string);
          } else if (operacao == 3) {
            controlador.atualizaMetrica(
                idMetrica.text, newMetrica.text);
            newMetrica.text = '';
            idMetrica.text = '';
          } else {
            debugPrint("Opção inválida no textfield Metricas");
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
