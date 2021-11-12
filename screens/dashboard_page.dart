import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/widgets/dashboard/app_bar/appBar_dash.dart';
import '/widgets/dashboard/menu_dash/side_menu_dash.dart';
import '/widgets/Dashboard/menu_dash/side_menu_gestor.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/dashboard/responsividade/small_screen_dash.dart';
import '/widgets/dashboard/responsividade/large_screen_dash.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';
import '/widgets/Dashboard/responsividade/large_screen_gestor.dart';

class Dashboard extends StatefulWidget {
  final String? tipo;
  Dashboard({
    Key? key,
    this.tipo,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Get.put(MenuControllerDash());
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: (widget.tipo == 'admin') ? SideMenuDash() : SideMenuGestor(),
      ),
      body: (widget.tipo == 'admin')
          ? ResponsiveWidget(
              largeScreen: LargeScreenDash(),
              smallScreen: SmallScreenDash(),
            )
          : ResponsiveWidget(
              largeScreen: LargeScreenGestor(),
              smallScreen: SmallScreenDash(),
            ),
    );
  }
}
