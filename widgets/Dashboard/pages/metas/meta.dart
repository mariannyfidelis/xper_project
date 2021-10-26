import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class Meta extends StatefulWidget {
  const Meta({Key? key}) : super(key: key);

  @override
  _MetaState createState() => _MetaState();
}

class _MetaState extends State<Meta> {
  List<TextEditingController> controladorMeta = <TextEditingController>[];

  addTextMeta() {
    controladorMeta.add(new TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    bool editavel = true;

    gerarProgresso(double realizado, double meta) {

      if (realizado != 0 && meta != 0) {
        double progresso = (realizado / meta) * 100;
        return progresso;
      } else {
        return 0;
      }
    }

    TextEditingController travaMeta = TextEditingController();
    TextEditingController idMetrica = TextEditingController();

    ControllerProjetoRepository listaMetricas =
    Get.find<ControllerProjetoRepository>();

    listaMetricas.listaMetricas.forEach((element) {
      controladorMeta.add(new TextEditingController());
    });

    //String meta = '';
    editavel.obs;

    return Scaffold(
      body: Center(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: "Metricas",
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
                  columns: [
                    DataColumn2(
                      label: Text('Metricas'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Realizado'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Meta(previsto)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Progresso'),
                      size: ColumnSize.M,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    listaMetricas.listaMetricas.length,
                        (index) => DataRow(
                      cells: [
                        DataCell(
                          CustomText(
                              text: listaMetricas
                                  .listaMetricas[index].nomeMetrica),
                        ),
                        DataCell(
                          CustomText(
                              text: listaMetricas.listaMetricas[index].realizado
                                  .toString()),
                        ),
                        DataCell(Row(
                          children: [
                            SizedBox(width: 25),
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                enabled: editavel,
                                controller: controladorMeta[index],

                                // onChanged: (text) {
                                //   meta = text;
                                // },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.lock),
                              onPressed: () {
                                idMetrica.text = listaMetricas
                                    .listaMetricas[index].idMetrica
                                    .toString();
                                Get.find<ControllerProjetoRepository>()
                                    .travarMeta(
                                    idMetrica.text,
                                    double.parse(
                                        controladorMeta[index].text));
                                // (idMetrica.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.update),
                                onPressed: () {
                                  if (listaMetricas.listaMetricas[index].meta !=
                                      null) {
                                    controladorMeta[index].text = listaMetricas
                                        .listaMetricas[index].meta
                                        .toString();
                                  }
                                }),
                          ],
                        )),
                        DataCell(
                          CustomText(
                              text:
                              '${gerarProgresso(listaMetricas.listaMetricas[index].realizado!, listaMetricas.listaMetricas[index].meta!)} %'

                            //'${(listaMetricas.listaMetricas[index].realizado! / listaMetricas.listaMetricas[index].meta!) * 100} %'
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
      floatingActionButton: Row(
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
          // Container(
          //     decoration: BoxDecoration(
          //         border: Border.all(color: PaletaCores.active, width: .5),
          //         color: PaletaCores.corLight,
          //         borderRadius: BorderRadius.circular(20)),
          //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: PaletaCores.corLight,
          //         elevation: 0,
          //         padding: EdgeInsets.symmetric(
          //           horizontal: 12,
          //           vertical: 6,
          //         ),
          //       ),
          //       onPressed: () {

          //       },
          //       child: CustomText(
          //         text: "Travar Metas",
          //         color: PaletaCores.active.withOpacity(.7),
          //         weight: FontWeight.bold,
          //       ),
          //     )),
        ],
      ),
    );
  }
}
