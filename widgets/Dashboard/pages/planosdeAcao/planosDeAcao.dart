import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class PlanosTable extends StatefulWidget {
  const PlanosTable({Key? key}) : super(key: key);

  @override
  _PlanosTableState createState() => _PlanosTableState();
}

class _PlanosTableState extends State<PlanosTable> {
  TextEditingController objetivoController = TextEditingController();
  TextEditingController resultadoController = TextEditingController();
  TextEditingController metricasController = TextEditingController();
  TextEditingController idObjetivoPai = TextEditingController();

  String idProjeto = "2qweqw23133";

  @override
  Widget build(BuildContext context) {

    ControllerProjetoRepository controllerProjetoRepository =
        Get.find<ControllerProjetoRepository>();

    return Container(
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 6),
              color: PaletaCores.corLightGrey.withOpacity(.1),
              blurRadius: 12),
        ],
        border: Border.all(color: PaletaCores.corLightGrey, width: .5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Adicionar Objetivos",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(controller: objetivoController),
          SizedBox(height: 20, width: 10),
          CustomText(
            text: "Resultados",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(controller: resultadoController),
          SizedBox(height: 20, width: 10),
          CustomText(
            text: "Adicionar Metricas",
            color: PaletaCores.corLightGrey,
            weight: FontWeight.bold,
          ),
          TextField(controller: metricasController),
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
                  //TODO - Realizar a validação dos textFields

                  if (objetivoController.text.isNotEmpty &&
                      resultadoController.text.isNotEmpty &&
                      metricasController.text.isNotEmpty) {

                    controllerProjetoRepository.addOneObjective(
                        idProjeto, objetivoController.text);

                    String objetivoProcura =
                        objetivoController.text.trim().toUpperCase();

                    controllerProjetoRepository.listaObjectives
                        .every((element) {
                      String nomeObjetivo = element.nome!.trim().toUpperCase();
                      if (nomeObjetivo == objetivoProcura) {
                        idObjetivoPai.text = element.idObjetivo!;
                        return true;
                      } else {
                        idObjetivoPai.text = "";
                      }
                      return false;
                    });

                    //controller.addResults(novoResultado);
                    controllerProjetoRepository.addOneResultado(
                        idProjeto, resultadoController.text,
                        idObjetivoPai: idObjetivoPai.text);

                    //TODO - Onde métrica fica vinculada
                    controllerProjetoRepository.addOneMetric(idProjeto, metricasController.text);

                    metricasController.text = "";
                    objetivoController.text = "";
                    idObjetivoPai.text = "";
                    resultadoController.text = "";
                  } else {
                    debugPrint(
                        "Todos os campos devem ser preenchidos no Plano de Ação");
                  }
                },
                child: CustomText(
                  text: "Adicionar objetivos - resultado - métrica",
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
