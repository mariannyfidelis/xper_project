import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/utils/paleta_cores.dart';

List<String> objetivos = [
  'OBTER A CERTIFICAÇÃO 56002  PARA O SINDICATO',
  'TER O MODELO DE NEGOCIO DIGITAL ATRAVES DE UMA PLATAFORMA IMPLANTADA E INTEGRADA',
  'CONTRIBUIR  PARA O CRESCIMENTO DAS EMPRESAS ASSOCIADAS'
];

class ObjetivosTable extends StatelessWidget {
  const ObjetivosTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String novoObjetivos = '';
    ControllerDashboard controller = ControllerDashboard.instance;
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
            text: "Adicionar Objetivos",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(onChanged: (text) {
            novoObjetivos = text;
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
                  controller.addObjects(novoObjetivos);
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
                  label: Text(''),
                  size: ColumnSize.L,
                ),
              ],
              rows: List<DataRow>.generate(
                controller.listObjects.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      CustomText(text: controller.listObjects[index]),
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
