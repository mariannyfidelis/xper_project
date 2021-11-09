import 'anexos_page.dart';
import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/screens/anexos_page.dart';
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
                    Text("Metas"),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      child: ElevatedButton(
                        child: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          Get.to(MetaCliente());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Anexos"),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 50,
                      child: ElevatedButton(
                        child: Icon(Icons.attach_file),
                        onPressed: () {
                          Get.to(AnexoPage());
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
  List<TextEditingController> controladorRealizado = <TextEditingController>[];
  addTextMeta() {
    controladorRealizado.add(new TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    bool editavel = true;

    TextEditingController travaMeta = TextEditingController();
    TextEditingController idMetrica = TextEditingController();

    ControllerProjetoRepository listaMetricas =
    Get.find<ControllerProjetoRepository>();

    listaMetricas.listaMetricas.forEach((element) {
      controladorRealizado.add(new TextEditingController());
    });

    //String meta = '';
    editavel.obs;

    gerarProgresso(double realizado, double meta) {
      if (realizado != 0 && meta != 0) {
        double progresso = (realizado / meta) * 100;
        return progresso;
      } else {
        return 0;
      }
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    18.0), //TODO: substituir pela mesma forma do donos
                child: Text('Adiciona Realizado'),
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
                              DataCell(Row(
                                children: [
                                  SizedBox(width: 25),
                                  Container(
                                    width: 40,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      enabled: editavel,
                                      controller: controladorRealizado[index],

                                      // onChanged: (text) {
                                      //   meta = text;
                                      // },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: () {
                                      idMetrica.text = listaMetricas
                                          .listaMetricas[index].idMetrica
                                          .toString();
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizarRealizado(
                                          idMetrica.text,
                                          double.parse(
                                              controladorRealizado[index]
                                                  .text));
                                      Get.find<ControllerProjetoRepository>()
                                          .atualizaObjetivoMandala(
                                          'a94afec7-fbad-4e39-809e-8eac0420b466',
                                          progresso: gerarProgresso(
                                              listaMetricas
                                                  .listaMetricas[index]
                                                  .realizado1!,
                                              listaMetricas
                                                  .listaMetricas[index]
                                                  .meta1!)
                                              .toDouble());
                                    },
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.update),
                                      onPressed: () {
                                        if (listaMetricas.listaMetricas[index]
                                            .realizado1 !=
                                            null) {
                                          controladorRealizado[index].text =
                                              listaMetricas.listaMetricas[index]
                                                  .realizado1
                                                  .toString();
                                        }
                                      }),
                                ],
                              )),
                              DataCell(
                                CustomText(
                                    text: listaMetricas
                                        .listaMetricas[index].meta1
                                        .toString()),
                              ),
                              DataCell(CustomText(
                                  text:
                                  '${gerarProgresso(listaMetricas.listaMetricas[index].realizado1!, listaMetricas.listaMetricas[index].meta1!)} %')),
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
