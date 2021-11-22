import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class MetaResultados extends StatefulWidget {
  const MetaResultados({Key? key}) : super(key: key);

  @override
  _MetaResultadosState createState() => _MetaResultadosState();
}

class _MetaResultadosState extends State<MetaResultados> {
  List<TextEditingController> controladorMeta = <TextEditingController>[];

  addTextMeta() {
    controladorMeta.add(new TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    bool editavel = true;

    ControllerProjetoRepository listaResultados =
        Get.find<ControllerProjetoRepository>();

    listaResultados.listaResultados.forEach((element) {
      controladorMeta.add(new TextEditingController());
    });

    editavel.obs;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: Container(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Resultados",
                        color: PaletaCores.corLightGrey,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                  Obx(
                    () => DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      dataRowHeight: 205,
                      //headingRowHeight: ,
                      columns: [
                        DataColumn2(
                          label: Text('Resultados'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Realizado'),
                          size: ColumnSize.M,
                        ),
                        DataColumn2(
                          label: Text('Meta (Prevista)'),
                          size: ColumnSize.M,
                        ),
                        DataColumn2(
                          label: Text('Progresso'),
                          size: ColumnSize.M,
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        listaResultados.listaResultados.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              CustomText(
                                  text: listaResultados
                                      .listaResultados[index].nomeResultado),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaResultados
                                        .realizadoResulMetric(
                                            5.0,
                                            listaResultados
                                                .listaResultados[index]
                                                .idResultado!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaResultados
                                        .metasResulMetric(
                                            5.0,
                                            listaResultados
                                                .listaResultados[index]
                                                .idResultado!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text:
                                        '\nGeral : ${listaResultados.gerarProgresso(listaResultados.realizadoResulMetric(0.0, listaResultados.listaResultados[index].idResultado!), listaResultados.metasResulMetric(0.0, listaResultados.listaResultados[index].idResultado!))} %\n\nQuarter 1 : ${listaResultados.gerarProgresso(listaResultados.realizadoResulMetric(1.0, listaResultados.listaResultados[index].idResultado!), listaResultados.metasResulMetric(1.0, listaResultados.listaResultados[index].idResultado!))} %\n\nQuarter 2 : ${listaResultados.gerarProgresso(listaResultados.realizadoResulMetric(2.0, listaResultados.listaResultados[index].idResultado!), listaResultados.metasResulMetric(2.0, listaResultados.listaResultados[index].idResultado!))} %\n\nQuarter 3 : ${listaResultados.gerarProgresso(listaResultados.realizadoResulMetric(3.0, listaResultados.listaResultados[index].idResultado!), listaResultados.metasResulMetric(3.0, listaResultados.listaResultados[index].idResultado!))} %\n\nQuarter 4 : ${listaResultados.gerarProgresso(listaResultados.realizadoResulMetric(4.0, listaResultados.listaResultados[index].idResultado!), listaResultados.metasResulMetric(4.0, listaResultados.listaResultados[index].idResultado!))} %\n'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            SizedBox(width: 12),
            Container(
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
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: "Voltar para Projetos",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                )),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
