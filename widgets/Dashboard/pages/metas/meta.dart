import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/pages/metas/tela_de_escolhas_meta.dart';

class Meta extends StatefulWidget {
  const Meta({Key? key}) : super(key: key);

  @override
  _MetaState createState() => _MetaState();
}

class _MetaState extends State<Meta> {
  List<TextEditingController> controladorMeta1 = <TextEditingController>[];
  List<TextEditingController> controladorMeta2 = <TextEditingController>[];
  List<TextEditingController> controladorMeta3 = <TextEditingController>[];
  List<TextEditingController> controladorMeta4 = <TextEditingController>[];

  addTextMeta() {
    controladorMeta1.add(new TextEditingController());
    controladorMeta2.add(new TextEditingController());
    controladorMeta3.add(new TextEditingController());
    controladorMeta4.add(new TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    double? raioButton = 16;
    bool editavel = true;

    TextEditingController travaMeta = TextEditingController();
    TextEditingController idMetrica = TextEditingController();

    ControllerProjetoRepository listaMetricas =
        Get.find<ControllerProjetoRepository>();

    listaMetricas.listaMetricas.forEach((element) {
      controladorMeta1.add(new TextEditingController());
      controladorMeta2.add(new TextEditingController());
      controladorMeta3.add(new TextEditingController());
      controladorMeta4.add(new TextEditingController());
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
                  dataRowHeight: 205,
                  columns: [
                    DataColumn2(
                      label: Text('Métricas'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Unidade'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Realizados (Q1,Q2,Q3,Q4)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Meta(Q1)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Meta(Q2)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Meta(Q3)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Meta(Q4)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Progresso'),
                      size: ColumnSize.M,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    listaMetricas.listaMetricas.length,
                    (index) =>
                        //=======================METRICAS==============================
                        DataRow(
                      cells: [
                        DataCell(
                          CustomText(
                              text: listaMetricas
                                  .listaMetricas[index].nomeMetrica),
                        ),
                        DataCell(
                          CustomText(
                              text: listaMetricas
                                  .listaMetricas[index].unidadeMedida),
                        ),
                        // =======================REALIZADO===============================
                        DataCell(SingleChildScrollView(
                            child: CustomText(
                            text:
                            '\nQuarter 1 : ${listaMetricas.listaMetricas[index].realizado1.toString()}\n\nQuarter 2 : ${listaMetricas.listaMetricas[index].realizado2.toString()}\n\nQuarter 3 : ${listaMetricas.listaMetricas[index].realizado3.toString()}\n\nQuarter 4 : ${listaMetricas.listaMetricas[index].realizado4.toString()}\n'))),
                        //=======================Q1==================================
                        DataCell(Row(
                          children: [
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                enabled: editavel,
                                controller: controladorMeta1[index],

                                // onChanged: (text) {
                                //   meta = text;
                                // },
                              ),
                            ),
                            IconButton(
                              splashRadius: raioButton,
                              icon: Icon(Icons.lock, size: 20),
                              onPressed: () {
                                idMetrica.text = listaMetricas
                                    .listaMetricas[index].idMetrica
                                    .toString();
                                Get.find<ControllerProjetoRepository>()
                                    .travarMetaMetrica(
                                        1,
                                        idMetrica.text,
                                        double.parse(
                                            controladorMeta1[index].text));
                                // (idMetrica.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                splashRadius: raioButton,
                                icon: Icon(Icons.update, size: 20),
                                onPressed: () {
                                  if (listaMetricas
                                          .listaMetricas[index].meta1 !=
                                      null) {
                                    controladorMeta1[index].text = listaMetricas
                                        .listaMetricas[index].meta1
                                        .toString();
                                  }
                                }),
                          ],
                        )),
                        //====================Q2========================
                        DataCell(Row(
                          children: [
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                enabled: editavel,
                                controller: controladorMeta2[index],

                                // onChanged: (text) {
                                //   meta = text;
                                // },
                              ),
                            ),
                            IconButton(
                              splashRadius: raioButton,
                              icon: Icon(Icons.lock, size: 20),
                              onPressed: () {
                                idMetrica.text = listaMetricas
                                    .listaMetricas[index].idMetrica
                                    .toString();
                                Get.find<ControllerProjetoRepository>()
                                    .travarMetaMetrica(
                                        2,
                                        idMetrica.text,
                                        double.parse(
                                            controladorMeta2[index].text));
                                // (idMetrica.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                splashRadius: raioButton,
                                icon: Icon(Icons.update, size: 20),
                                onPressed: () {
                                  if (listaMetricas
                                          .listaMetricas[index].meta2 !=
                                      null) {
                                    controladorMeta2[index].text = listaMetricas
                                        .listaMetricas[index].meta2
                                        .toString();
                                  }
                                }),
                          ],
                        )),
                        //===========================Q3============================
                        DataCell(Row(
                          children: [
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                enabled: editavel,
                                controller: controladorMeta3[index],

                                // onChanged: (text) {
                                //   meta = text;
                                // },
                              ),
                            ),
                            IconButton(
                              splashRadius: raioButton,
                              icon: Icon(Icons.lock, size: 20),
                              onPressed: () {
                                idMetrica.text = listaMetricas
                                    .listaMetricas[index].idMetrica
                                    .toString();
                                Get.find<ControllerProjetoRepository>()
                                    .travarMetaMetrica(
                                        3,
                                        idMetrica.text,
                                        double.parse(
                                            controladorMeta3[index].text));
                                // (idMetrica.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                splashRadius: raioButton,
                                icon: Icon(Icons.update, size: 20),
                                onPressed: () {
                                  if (listaMetricas
                                          .listaMetricas[index].meta3 !=
                                      null) {
                                    controladorMeta3[index].text = listaMetricas
                                        .listaMetricas[index].meta3
                                        .toString();
                                  }
                                }),
                          ],
                        )),
                        DataCell(Row(
                          children: [
                            Container(
                              width: 40,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                enabled: editavel,
                                controller: controladorMeta4[index],

                                // onChanged: (text) {
                                //   meta = text;
                                // },
                              ),
                            ),
                            IconButton(
                              splashRadius: raioButton,
                              icon: Icon(Icons.lock, size: 20),
                              onPressed: () {
                                idMetrica.text = listaMetricas
                                    .listaMetricas[index].idMetrica
                                    .toString();
                                Get.find<ControllerProjetoRepository>()
                                    .travarMetaMetrica(
                                        4,
                                        idMetrica.text,
                                        double.parse(
                                            controladorMeta4[index].text));
                                // (idMetrica.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                splashRadius: raioButton,
                                icon: Icon(Icons.update, size: 20),
                                onPressed: () {
                                  if (listaMetricas
                                          .listaMetricas[index].meta4 !=
                                      null) {
                                    controladorMeta4[index].text = listaMetricas
                                        .listaMetricas[index].meta4
                                        .toString();
                                  }
                                }),
                          ],
                        )),

                        DataCell(
                          CustomText(
                              text: '\nGeral : ${listaMetricas.gerarProgressoGeral(
                            listaMetricas.listaMetricas[index].realizado1!,
                            listaMetricas.listaMetricas[index].realizado2!,
                            listaMetricas.listaMetricas[index].realizado3!,
                            listaMetricas.listaMetricas[index].realizado4!,
                            listaMetricas.listaMetricas[index].meta1!,
                            listaMetricas.listaMetricas[index].meta2!,
                            listaMetricas.listaMetricas[index].meta3!,
                            listaMetricas.listaMetricas[index].meta4!,
                          )} % \n\nQuarter 1 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado1!, listaMetricas.listaMetricas[index].meta1!)} %\n\nQuarter 2 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado2!, listaMetricas.listaMetricas[index].meta2!)} %\n\nQuarter 3 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado3!, listaMetricas.listaMetricas[index].meta3!)} %\n\nQuarter 4 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado4!, listaMetricas.listaMetricas[index].meta4!)} %\n'

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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TelaEscolhas()));
                },
                child: CustomText(
                  text: "Voltar para Projetos",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
