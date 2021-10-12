import 'package:get/get.dart';
import '/widgets/Dashboard/pages/donos/donos_dash.dart';
import '/widgets/Dashboard/pages/objetivos/objetivos_page_dash.dart';
import '/widgets/Dashboard/pages/resultados/resultados_page_dash.dart';
import '/widgets/Dashboard/pages/metricas/metricas_dash.dart';

import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

MenuControllerDash menuControllerDash = MenuControllerDash.instance;
NavigationControllerDash navigationController =
    NavigationControllerDash.instance;

class ControllerDashboard extends GetxController {
  static ControllerDashboard instance = Get.put(ControllerDashboard());

  var listMetrics = metricas.obs;
  var listResults = resultados.obs;
  var listObjects = objetivos.obs;
  var listDonos = donos.obs;
  //var listMetas = metas.obs;

  //TODO: addMetrics addResults addObjects addDono addMetas
  void addMetrics(String value) {
    listMetrics.add(value);
  }

  void addResults(String value) {
    listResults.add(value);
  }

  void addObjects(String value) {
    listObjects.add(value);
  }

  void addDono(String value) {
    listDonos.add(value);
  }

  void addMetas(String value) {
    //listMetas.add(value);
  }
}
