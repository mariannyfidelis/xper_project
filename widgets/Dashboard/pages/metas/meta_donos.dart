import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class MetaDonos extends StatefulWidget {
  const MetaDonos({Key? key}) : super(key: key);

  @override
  _MetaDonosState createState() => _MetaDonosState();
}

class _MetaDonosState extends State<MetaDonos> {
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
    TextEditingController idDonos = TextEditingController();

    ControllerProjetoRepository listaDonos =
        Get.find<ControllerProjetoRepository>();

    listaDonos.listaDonos.forEach((element) {
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
                    text: "Donos",
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
                      label: Text('Donos'),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Realizado'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('MetaDonos(previsto)'),
                      size: ColumnSize.M,
                    ),
                    DataColumn2(
                      label: Text('Progresso'),
                      size: ColumnSize.M,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    listaDonos.listaDonos.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          CustomText(text: listaDonos.listaDonos[index].nome),
                        ),
                        DataCell(
                          CustomText(text: '0'),
                          //     .listaDonos[index].realizado
                          //     .toString()),
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
                                idDonos.text = listaDonos
                                    .listaDonos[index].email
                                    .toString();

                                // Get.find<ControllerProjetoRepository>()
                                //     .travarMeta(
                                //         idDonos.text,
                                //         double.parse(
                                //             controladorMeta[index].text));
                                // (idDonos.text,
                                //     double.parse(controladorMeta[index].text));
                                // editavel = false;
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.update),
                                onPressed: () {
                                  idDonos.text = listaDonos
                                      .listaDonos[index].email
                                      .toString();
                                  // listaDonos.metaDonos(
                                  //     listaDonos.listaDonos[index].id
                                  //         .toString(),
                                  //     listaDonos.listaDonos[index].email
                                  //         .toString(),
                                  //     listaDonos.listaDonos[index].nome
                                  //         .toString());
                                  // if (listaDonos
                                  //         .listaDonos[index].meta !=
                                  //     null) {
                                  //   controladorMeta[index].text =
                                  //       listaDonos
                                  //           .listaDonos[index].meta
                                  //           .toString();
                                  //}
                                }),
                          ],
                        )),
                        DataCell(
                          CustomText(text: ''
                              //  '${gerarProgresso(listaDonos.listaDonos[index].realizado!, listaDonos.listaDonos[index].meta!)} %'

                              //'${(listaDonos.listaDonos[index].realizado! / listaDonos.listaDonos[index].meta!) * 100} %'
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
