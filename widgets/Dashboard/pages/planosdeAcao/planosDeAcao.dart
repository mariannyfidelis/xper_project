import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/pages/metricas/metricas_dash.dart';
import '/widgets/Dashboard/pages/objetivos/objetivos_page_dash.dart';
import '/widgets/Dashboard/pages/resultados/resultados_page_dash.dart';
import '/utils/paleta_cores.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';

class PlanosTable extends StatelessWidget {
  const PlanosTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllerDashboard controller = ControllerDashboard.instance;
    String novoObjetivo = '';
    String novoResultado = '';
    String novaMetrica = '';
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
            novoObjetivo = text;
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
                  controller.addObjects(novoObjetivo);
                },
                child: CustomText(
                  text: "Adicionar",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 30),
          CustomText(
            text: "Adicionar Resultados",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(onChanged: (text) {
            novoResultado = text;
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
                  controller.addResults(novoResultado);
                },
                child: CustomText(
                  text: "Adicionar",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 30),
          CustomText(
            text: "Adicionar Metrivas",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(onChanged: (text) {
            novaMetrica = text;
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
                  controller.addMetrics(novaMetrica);
                },
                child: CustomText(
                  text: "Adicionar",
                  color: PaletaCores.active.withOpacity(.7),
                  weight: FontWeight.bold,
                ),
              )),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
