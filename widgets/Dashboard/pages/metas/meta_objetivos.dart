import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class MetaObjetivos extends StatefulWidget {
  const MetaObjetivos({Key? key}) : super(key: key);

  @override
  _MetaObjetivosState createState() => _MetaObjetivosState();
}

class _MetaObjetivosState extends State<MetaObjetivos> {
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
    TextEditingController idObjetivo = TextEditingController();

    ControllerProjetoRepository listaObjetivos =
        Get.find<ControllerProjetoRepository>();

    listaObjetivos.listaObjectives.forEach((element) {
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
                    text: "Objetivos",
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
                      label: Text('Objetivos'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Realizado'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('MetaObjetivos(previsto)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Progresso'),
                      size: ColumnSize.M,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    listaObjetivos.listaObjectives.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          CustomText(
                              text: listaObjetivos.listaObjectives[index].nome),
                        ),
                        DataCell(
                          CustomText(text: '0'),
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
                                idObjetivo.text = listaObjetivos
                                    .listaObjectives[index].idObjetivo
                                    .toString();
                                listaObjetivos.travaMetaObj(idObjetivo.text,
                                    double.parse(controladorMeta[index].text));
                                // Get.find<ControllerProjetoRepository>()
                                //     .travarMeta(
                                //         idObjetivo.text,
                                //         double.parse(
                                //             controladorMeta[index].text));
                                // (idObjetivo.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.update),
                                onPressed: () {
                                  idObjetivo.text = listaObjetivos
                                      .listaObjectives[index].idObjetivo
                                      .toString();
                                  controladorMeta[index].text = listaObjetivos
                                      .metaObjetivos(idObjetivo.text)
                                      .toString();
                                  // if (listaObjetivos
                                  //         .listaObjectives[index].meta !=
                                  //     null) {
                                  //   controladorMeta[index].text = listaObjetivos
                                  //       .listaObjetivos[index].meta
                                  //       .toString();
                                  // }
                                }),
                          ],
                        )),
                        DataCell(
                          CustomText(text: '%'
                              // '${gerarProgresso(listaObjetivos.listaObjetivos[index].realizado!, listaObjetivos.listaObjetivos[index].meta!)} %'

                              //'${(listaObjetivos.listaObjetivos[index].realizado! / listaObjetivos.listaObjetivos[index].meta!) * 100} %'
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
        ],
      ),
    );
  }
}
