import 'dart:js';
import 'package:flutter/widgets.dart';
import 'controller/controllers_dash.dart';
import '/widgets/Dashboard/router_dash.dart';
import '/widgets/Dashboard/routes_dash.dart';

Navigator localNavigatorDash() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: OverViewPageRouteDash,
      onGenerateRoute: generateRoute,
    );
