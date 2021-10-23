import 'package:get/get.dart';
import '/database/db_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/dashboard/app_bar/appBar_dash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/dashboard/menu_dash/side_menu_dash.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/dashboard/responsividade/small_screen_dash.dart';
import '/widgets/dashboard/responsividade/large_screen_dash.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';

class Dashboard extends StatefulWidget {
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
        child: SideMenuDash(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreenDash(),
        smallScreen: SmallScreenDash(),
      ),
    );
  }
}
