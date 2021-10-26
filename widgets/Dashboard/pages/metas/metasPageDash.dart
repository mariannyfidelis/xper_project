import 'meta.dart';
import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class MetasTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ControllerProjetoRepository listaProjetos = Get.find<ControllerProjetoRepository>();

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
                text: "Projetos",
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
                listaProjetos.listaProjetos.length, //controller.listMetas.length,
                    (index) => DataRow(
                  cells: [
                    DataCell(
                        CustomText(
                          text: listaProjetos.listaProjetos[index].nome,
                        ), onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Meta()));
                    }),
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

