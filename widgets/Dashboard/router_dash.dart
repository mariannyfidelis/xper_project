import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/screens/projeto_pagina_principal.dart';
import '/widgets/Dashboard/pages/ajuda/menu_ajuda.dart';
import '/widgets/Dashboard/pages/metas/metasdash.dart';
import '/widgets/Dashboard/pages/planosdeAcao/planos_dash.dart';
import '/widgets/Dashboard/pages/metricas/metricaspage.dart';
import '/widgets/Dashboard/pages/donos/donospage.dart';
import '/widgets/Dashboard/pages/objetivos/objetivos_dash.dart';
import '/widgets/Dashboard/pages/resultados/resultados_dash.dart';

import '/widgets/Dashboard/pages/authentication/cadastro_cliente_gerenciador.dart';
import '/widgets/Dashboard/pages/clients/clients_dash.dart';
import '/widgets/Dashboard/pages/overview/overview_dash.dart';
import '/widgets/Dashboard/routes_dash.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AjudaPageRouteDash:
      return _getPageRoute(AjudaPageDash());
    case OverViewPageRouteDash:
      return _getPageRoute(OverViewPageDash());
    case ObjetivosDaequipePageRouteDash:
      return _getPageRoute(ObjetivosPageDash());
    case ResultadosPageRouteDash:
      return _getPageRoute(ResultadosPageDash());
    case MetricasPageRouteDash:
      return _getPageRoute(MetricasPageDash());
    case DonosPageRouteDash:
      return _getPageRoute(DonosPageDash());
    case MetasPageRouteDash:
      return _getPageRoute(MetasPageDash());
    case ClientsPageRouteDash:
      return _getPageRoute(ClientsPageDash());
    case CadastroADMRouteDash:
      return _getPageRoute(CadastroPage(title: "Cadastrar Cliente"));
    case PlanodeAcaoPageRouteDash:
      return _getPageRoute(PlanosPageDash());
    case ProjetoPageRouteDash:
      return _getPageRoute(ProjetoPage());

    default:
      return _getPageRoute(OverViewPageDash());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
