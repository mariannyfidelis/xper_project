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
    ControllerProjetoRepository listaDonos =
        Get.find<ControllerProjetoRepository>();

    listaDonos.listaDonos.forEach((element) {
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
                      dataRowHeight: 205,
                      columns: [
                        DataColumn2(
                          label: Text('Donos'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Realizados'),
                          size: ColumnSize.M,
                        ),
                        DataColumn2(
                          label: Text('Metas (previsto)'),
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
                                CustomText(
                                    text: listaDonos.listaDonos[index].nome),
                                onTap: () {
                              var results = listaDonos.listaResultados.where(
                                  (element) => element.donoResultado!.contains(
                                      listaDonos.listaDonos[index].email));

                              var objetives = listaDonos.listaObjectives.where(
                                  (element) => element.donos!.contains(
                                      listaDonos.listaDonos[index].email));

                              var metricas = listaDonos.listaMetricas.where(
                                  (element) => element.donos!.contains(
                                      listaDonos.listaDonos[index].email));
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                      title: Center(
                                        child: Text(
                                            "Responsabilidades de ${listaDonos.listaDonos[index].nome}"),
                                      ),
                                      content: Container(
                                          height: 200,
                                          child: SingleChildScrollView(
                                            child: Column(children: [
                                              Text('Objetivos Principais'),
                                              SingleChildScrollView(
                                                  child: Column(children: [
                                                for (var i in objetives)
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              bottom: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Text('${i.nome}',
                                                              style: TextStyle(
                                                                  color: PaletaCores
                                                                      .corPrimaria,
                                                                  fontSize:
                                                                      15)),
                                                          Expanded(
                                                              child: Container(
                                                                  width: 25)),
                                                          Text(
                                                              '${listaDonos.gerarProgresso(listaDonos.realizadoObjetivos(0.0, i.idObjetivo!), listaDonos.metaObjetivos(0.0, i.idObjetivo!))} %',
                                                              style: TextStyle(
                                                                  color: PaletaCores
                                                                      .corPrimaria,
                                                                  fontSize:
                                                                      15)),
                                                        ],
                                                      )),
                                              ])),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text('Resultados Principais'),
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    for (var i in results)
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 8.0,
                                                                  bottom: 8.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  '${i.nomeResultado}',
                                                                  style: TextStyle(
                                                                      color: PaletaCores
                                                                          .corPrimaria,
                                                                      fontSize:
                                                                          15)),
                                                              Expanded(
                                                                  child: Container(
                                                                      width:
                                                                          25)),
                                                              Text(
                                                                  '${listaDonos.gerarProgresso(listaDonos.realizadoResulMetric(0.0, i.idResultado!), listaDonos.metasResulMetric(0.0, i.idResultado!))} %',
                                                                  style: TextStyle(
                                                                      color: PaletaCores
                                                                          .corPrimaria,
                                                                      fontSize:
                                                                          15)),
                                                            ],
                                                          )),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text('Metricas'),
                                                    SingleChildScrollView(
                                                      child: Column(children: [
                                                        for (var i in metricas)
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      bottom:
                                                                          8.0),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                      '${i.nomeMetrica}',
                                                                      style: TextStyle(
                                                                          color: PaletaCores
                                                                              .corPrimaria,
                                                                          fontSize:
                                                                              15)),
                                                                  Expanded(
                                                                      child: Container(
                                                                          width:
                                                                              25)),
                                                                  Text(
                                                                      '${listaDonos.gerarProgressoGeral(
                                                                        i.realizado1!,
                                                                        i.realizado2!,
                                                                        i.realizado3!,
                                                                        i.realizado4!,
                                                                        i.meta1!,
                                                                        i.meta2!,
                                                                        i.meta3!,
                                                                        i.meta4!,
                                                                      )} %',
                                                                      style: TextStyle(
                                                                          color: PaletaCores
                                                                              .corPrimaria,
                                                                          fontSize:
                                                                              15)),
                                                                ],
                                                              ))
                                                      ]),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ))));
                            }),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaDonos
                                        .realizadosDono(5.0,
                                            listaDonos.listaDonos[index].email!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text: listaDonos
                                        .metasDono(5.0,
                                            listaDonos.listaDonos[index].email!)
                                        .toString()),
                              ),
                            ),
                            DataCell(
                              SingleChildScrollView(
                                child: CustomText(
                                    text:
                                        '\nGeral : ${listaDonos.gerarProgresso(listaDonos.realizadosDono(0.0, listaDonos.listaDonos[index].email!), listaDonos.metasDono(0.0, listaDonos.listaDonos[index].email!))} %\n\nQuarter 1 : ${listaDonos.gerarProgresso(listaDonos.realizadosDono(1.0, listaDonos.listaDonos[index].email!), listaDonos.metasDono(1.0, listaDonos.listaDonos[index].email!))} %\n\nQuarter 2 : ${listaDonos.gerarProgresso(listaDonos.realizadosDono(2.0, listaDonos.listaDonos[index].email!), listaDonos.metasDono(2.0, listaDonos.listaDonos[index].email!))} %\n\nQuarter 3 : ${listaDonos.gerarProgresso(listaDonos.realizadosDono(3.0, listaDonos.listaDonos[index].email!), listaDonos.metasDono(3.0, listaDonos.listaDonos[index].email!))} %\n\nQuarter 4 : ${listaDonos.gerarProgresso(listaDonos.realizadosDono(4.0, listaDonos.listaDonos[index].email!), listaDonos.metasDono(4.0, listaDonos.listaDonos[index].email!))} %\n'),
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
