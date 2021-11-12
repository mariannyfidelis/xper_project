import 'package:flutter/widgets.dart';
import '/widgets/Dashboard/router_gestor.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

import '/widgets/Dashboard/routes_dash.dart';

Navigator localNavigatorGestor() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: OverViewPageRouteDash,
  onGenerateRoute: generateRouteGestor,
);
