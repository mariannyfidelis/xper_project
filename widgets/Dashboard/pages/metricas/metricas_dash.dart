import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/utils/paleta_cores.dart';

List<String> metricas = [
  'Nr de Qualificados',
  'Projetos por criterio',
  'Nr de Iniciativas',
  'Nr de Empresas Certificadas',
  'Projeto do Modelo de Negócio',
  'Nr de Funcionalidades',
  'Projeto da Plataforma'
];

/*
class MetricasTable extends StatefulWidget {
  const MetricasTable({Key? key}) : super(key: key);

  @override
  _MetricasTableState createState() => _MetricasTableState();
}

class _MetricasTableState extends State<MetricasTable> {
  String novoMetrica = '';

  @override
  Widget build(BuildContext context) {
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
          TextField(onChanged: (text) {
            novoMetrica = text;
          }),
          SizedBox(height: 20, width: 10),
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
                  metricas.add(novoMetrica);
                  setState(() {
                    MetricasTable();
                  });
                },
                child: CustomText(
                  text: "Adicionar",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              )),
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
          DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: [
              DataColumn2(
                label: Text(''),
                size: ColumnSize.L,
              ),
            ],
            rows: List<DataRow>.generate(
              metricas.length,
              (index) => DataRow(
                cells: [
                  DataCell(
                    CustomText(text: metricas[index]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

class MetricasTable extends StatelessWidget {
  const MetricasTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerDashboard controller = ControllerDashboard.instance;
    String novoMetrica = '';

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
          TextField(onChanged: (text) {
            novoMetrica = text;
          }),
          SizedBox(height: 20, width: 10),
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
                  controller.addMetrics(novoMetrica);
                },
                child: CustomText(
                  text: "Adicionar",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              )),
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
                  label: Text(''),
                  size: ColumnSize.L,
                ),
              ],
              rows: List<DataRow>.generate(
                controller.listMetrics.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      CustomText(text: controller.listMetrics[index]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
