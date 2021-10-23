import 'package:get/get.dart';
import 'package:xper_brasil_projects/widgets/Dashboard/controller/controllers_dash.dart';

import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/pages/resultados/resultados_page_dash.dart';

class MetasTable extends StatelessWidget {
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
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Metas",
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
                label: Text('Objetivos'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Resultados Principais'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Metricas'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Dono'),
                size: ColumnSize.M,
              ),
            ],
            rows: List<DataRow>.generate(
              Get.find<ControllerProjetoRepository>().listaResultados.length,
              (index) => DataRow(
                cells: [
                  DataCell(
                    CustomText(text:"objetivos")
                    //CustomText(text: objetivos[index]),
                  ),
                  DataCell(
                    CustomText(text:"resultados"),
                    //CustomText(text: resultados[index]),
                  ),
                  DataCell(
                    CustomText(text:"metricas")
                    //CustomText(text: metricas[index]),
                  ),
                  DataCell(
                    CustomText(text:"donos")
                    //CustomText(text: donos[index]),
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
