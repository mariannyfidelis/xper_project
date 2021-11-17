import '/screens/home_web.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/routes_gestor.dart';
import '/widgets/Dashboard/pages/donos/donospage.dart';
import '/widgets/Dashboard/pages/metas/metasdash.dart';
import '/widgets/Dashboard/pages/ajuda/menu_ajuda.dart';
import '/widgets/Dashboard/pages/metricas/metricaspage.dart';
import '/widgets/Dashboard/pages/clients/clients_gestor.dart';
import '/widgets/Dashboard/pages/overview/overview_dash.dart';
import '/widgets/Dashboard/pages/planosdeAcao/planos_dash.dart';
import '/widgets/Dashboard/pages/overview/overview_gestor.dart';
import '/widgets/Dashboard/pages/resultados/resultados_dash.dart';
import '/widgets/Dashboard/pages/objetivos/objetivos_page_dash.dart';

Route<dynamic>? generateRouteGestor(RouteSettings settings) {
  switch (settings.name) {
    case AjudaPageRouteGestor:
      return _getPageRoute(AjudaPageDash());
    case OverViewPageRouteGestor:
      return _getPageRoute(OverViewPageGestor());
    case ObjetivosDaequipePageRouteGestor:
      return _getPageRoute(ObjetivosPageDash());
    case ResultadosPageRouteGestor:
      return _getPageRoute(ResultadosPageDash());
    case MetricasPageRouteGestor:
      return _getPageRoute(MetricasPageDash());
    case DonosPageRouteGestor:
      return _getPageRoute(DonosPageDash());
    case MetasPageRouteGestor:
      return _getPageRoute(MetasPageDash());
    case ClientsPageRouteGestor:
      return _getPageRoute(ClientsPageDashGestor());
    case PlanodeAcaoPageRouteGestor:
      return _getPageRoute(PlanosPageDash());
    case ProjetoPageRouteGestor:
      return _getPageRoute(HomeWeb(tipo: 'gerenciador'));

    default:
      return _getPageRoute(OverViewPageDash());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
