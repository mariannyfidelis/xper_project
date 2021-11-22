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

    ControllerProjetoRepository listaObjetivos =
        Get.find<ControllerProjetoRepository>();

    listaObjetivos.listaObjectives.forEach((element) {
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
                      dataRowHeight: 205,
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
                                  text: listaObjetivos
                                      .listaObjectives[index].nome),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaObjetivos
                                        .realizadoObjetivos(
                                            5.0,
                                            listaObjetivos
                                                .listaObjectives[index]
                                                .idObjetivo!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaObjetivos
                                        .metaObjetivos(
                                            5.0,
                                            listaObjetivos
                                                .listaObjectives[index]
                                                .idObjetivo!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text:
                                        '\nGeral : ${listaObjetivos.gerarProgresso(listaObjetivos.realizadoObjetivos(0.0, listaObjetivos.listaObjectives[index].idObjetivo!), listaObjetivos.metaObjetivos(0.0, listaObjetivos.listaObjectives[index].idObjetivo!))} %\n\nQuarter 1 : ${listaObjetivos.gerarProgresso(listaObjetivos.realizadoObjetivos(1.0, listaObjetivos.listaObjectives[index].idObjetivo!), listaObjetivos.metaObjetivos(1.0, listaObjetivos.listaObjectives[index].idObjetivo!))} %\n\nQuarter 2 : ${listaObjetivos.gerarProgresso(listaObjetivos.realizadoObjetivos(2.0, listaObjetivos.listaObjectives[index].idObjetivo!), listaObjetivos.metaObjetivos(2.0, listaObjetivos.listaObjectives[index].idObjetivo!))} %\n\nQuarter 3 : ${listaObjetivos.gerarProgresso(listaObjetivos.realizadoObjetivos(3.0, listaObjetivos.listaObjectives[index].idObjetivo!), listaObjetivos.metaObjetivos(3.0, listaObjetivos.listaObjectives[index].idObjetivo!))} %\n\nQuarter 4 : ${listaObjetivos.gerarProgresso(listaObjetivos.realizadoObjetivos(4.0, listaObjetivos.listaObjectives[index].idObjetivo!), listaObjetivos.metaObjetivos(4.0, listaObjetivos.listaObjectives[index].idObjetivo!))} %\n'),
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
