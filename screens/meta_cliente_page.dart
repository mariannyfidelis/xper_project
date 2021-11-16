import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/screens/anexos_page.dart';
import '/models/metricasModel.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class TelaMeta extends StatefulWidget {
  const TelaMeta({Key? key}) : super(key: key);

  @override
  _TelaMetaState createState() => _TelaMetaState();
}

class _TelaMetaState extends State<TelaMeta> {
  String _dataVencimento = "";
  ControllerProjetoRepository listaMetricas =
      Get.find<ControllerProjetoRepository>();

  @override
  Widget build(BuildContext context) {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    return Obx(
      () => Visibility(
        visible: mandalaController.visivel.value,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Metas",
                        style: TextStyle(color: PaletaCores.textColor)),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      child: ElevatedButton(
                        child: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          Get.to(() => MetaCliente());
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Text("Anexos",
                        style: TextStyle(color: PaletaCores.textColor)),
                    SizedBox(width: 20),
                    Container(
                      width: 50,
                      child: ElevatedButton(
                        child: Icon(Icons.attach_file),
                        onPressed: () {
                          Get.to(() =>AnexoPage());
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MetaCliente extends StatefulWidget {
  const MetaCliente({Key? key}) : super(key: key);

  @override
  _MetaClienteState createState() => _MetaClienteState();
}

class _MetaClienteState extends State<MetaCliente> {
  List<TextEditingController> controladorRealizado1 = <TextEditingController>[];
  List<TextEditingController> controladorRealizado2 = <TextEditingController>[];
  List<TextEditingController> controladorRealizado3 = <TextEditingController>[];
  List<TextEditingController> controladorRealizado4 = <TextEditingController>[];

  @override
  Widget build(BuildContext context) {

    bool editavel = true;
    double? raioButton = 16;

    TextEditingController idMetrica = TextEditingController();

    ControllerProjetoRepository listaMetricas =
        Get.find<ControllerProjetoRepository>();
    var lm = listaMetricas.listaMetricas.where((element) =>
        element.idResultado == listaMetricas.ultimoResultadoClicado.value);

    List<MetricasPrincipais> metricas = <MetricasPrincipais>[].obs;
    if (listaMetricas.ultimoNivelClicado.value == 3) {
      for (var m in lm) {
        metricas.add(m);
      }
    } else if (listaMetricas.ultimoNivelClicado.value == 2) {
      metricas.clear();
    }

    metricas.forEach((element) {
      controladorRealizado1.add(new TextEditingController());
      controladorRealizado2.add(new TextEditingController());
      controladorRealizado3.add(new TextEditingController());
      controladorRealizado4.add(new TextEditingController());
    });

    //String meta = '';
    editavel.obs;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    18.0), //TODO: substituir pela mesma forma do donos
                child: Text(
                  'Adicionar Realizado',
                  style: TextStyle(color: PaletaCores.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
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
                    border:
                        Border.all(color: PaletaCores.corLightGrey, width: .5)),
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
                            label: Text('Metricas'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Text('Realizado (Q1)'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Realizado (Q2)'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Realizado (Q3)'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Realizado (Q4)'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Metas (previstas)'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: Text('Progresso por Quarter'),
                            size: ColumnSize.M,
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          metricas.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                CustomText(text: metricas[index].nomeMetrica),
                              ),
                              DataCell(Row(
                                children: [
                                  Container(
                                    width: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      enabled: editavel,
                                      controller: controladorRealizado1[index],
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: raioButton,
                                    icon: Icon(Icons.lock, size: 20),
                                    onPressed: () {
                                      idMetrica.text =
                                          metricas[index].idMetrica.toString();
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizarRealizado(
                                              1,
                                              idMetrica.text,
                                              double.parse(
                                                  controladorRealizado1[index]
                                                      .text));
                                    },
                                  ),
                                  IconButton(
                                      splashRadius: raioButton,
                                      icon: Icon(Icons.update, size: 20),
                                      onPressed: () {
                                        if (listaMetricas
                                                .listaMetricas[index].meta1 !=
                                            null) {
                                          controladorRealizado1[index].text =
                                              metricas[index]
                                                  .realizado1
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
                                      controller: controladorRealizado2[index],

                                      // onChanged: (text) {
                                      //   meta = text;
                                      // },
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: raioButton,
                                    icon: Icon(Icons.lock, size: 20),
                                    onPressed: () {
                                      idMetrica.text =
                                          metricas[index].idMetrica.toString();
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizarRealizado(
                                              2,
                                              idMetrica.text,
                                              double.parse(
                                                  controladorRealizado2[index]
                                                      .text));
                                      // (idMetrica.text,
                                      //     double.parse(controladorMeta[index].text));
                                      // editavel = false;
                                    },
                                  ),
                                  IconButton(
                                      splashRadius: raioButton,
                                      icon: Icon(Icons.update, size: 20),
                                      onPressed: () {
                                        if (metricas[index].meta2 != null) {
                                          controladorRealizado2[index].text =
                                              metricas[index]
                                                  .realizado2
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
                                      controller: controladorRealizado3[index],

                                      // onChanged: (text) {
                                      //   meta = text;
                                      // },
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: raioButton,
                                    icon: Icon(Icons.lock, size: 20),
                                    onPressed: () {
                                      idMetrica.text =
                                          metricas[index].idMetrica.toString();
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizarRealizado(
                                              3,
                                              idMetrica.text,
                                              double.parse(
                                                  controladorRealizado3[index]
                                                      .text));
                                      // (idMetrica.text,
                                      //     double.parse(controladorMeta[index].text));
                                      // editavel = false;
                                    },
                                  ),
                                  IconButton(
                                      splashRadius: raioButton,
                                      icon: Icon(Icons.update, size: 20),
                                      onPressed: () {
                                        if (metricas[index].meta3 != null) {
                                          controladorRealizado3[index].text =
                                              metricas[index]
                                                  .realizado3
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
                                      controller: controladorRealizado4[index],

                                      // onChanged: (text) {
                                      //   meta = text;
                                      // },
                                    ),
                                  ),
                                  IconButton(
                                    splashRadius: raioButton,
                                    icon: Icon(Icons.lock, size: 20),
                                    onPressed: () {
                                      idMetrica.text =
                                          metricas[index].idMetrica.toString();
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizarRealizado(
                                              4,
                                              idMetrica.text,
                                              double.parse(
                                                  controladorRealizado4[index]
                                                      .text));
                                      // (idMetrica.text,
                                      //     double.parse(controladorMeta[index].text));
                                      // editavel = false;
                                    },
                                  ),
                                  IconButton(
                                      splashRadius: raioButton,
                                      icon: Icon(Icons.update, size: 20),
                                      onPressed: () {
                                        if (metricas[index].meta4 != null) {
                                          controladorRealizado4[index].text =
                                              metricas[index]
                                                  .realizado4
                                                  .toString();
                                        }
                                      }),
                                ],
                              )),
                              DataCell(SingleChildScrollView(
                                  child: CustomText(
                                      text:
                                          '\nQuarter 1 : ${metricas[index].meta1.toString()}\n\nQuarter 2 : ${metricas[index].meta2.toString()}\n\nQuarter 3 : ${metricas[index].meta3.toString()}\n\nQuarter 4 : ${metricas[index].meta4.toString()}\n'))),
                              DataCell(SingleChildScrollView(
                                child: CustomText(
                                    text:
                                        '\nGeral : ${listaMetricas.gerarProgressoGeral(
                                  listaMetricas
                                      .listaMetricas[index].realizado1!,
                                  listaMetricas
                                      .listaMetricas[index].realizado2!,
                                  listaMetricas
                                      .listaMetricas[index].realizado3!,
                                  listaMetricas
                                      .listaMetricas[index].realizado4!,
                                  listaMetricas.listaMetricas[index].meta1!,
                                  listaMetricas.listaMetricas[index].meta2!,
                                  listaMetricas.listaMetricas[index].meta3!,
                                  listaMetricas.listaMetricas[index].meta4!,
                                )} %\n\nQuarter 1 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado1!, listaMetricas.listaMetricas[index].meta1!)} %\n\nQuarter 2 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado2!, listaMetricas.listaMetricas[index].meta2!)} %\n\nQuarter 3 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado3!, listaMetricas.listaMetricas[index].meta3!)} %\n\nQuarter 4 : ${listaMetricas.gerarProgresso(listaMetricas.listaMetricas[index].realizado4!, listaMetricas.listaMetricas[index].meta4!)} %\n'),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: "Voltar para Mandala",
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
