import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 14),
                    child: Icon(
                      Icons.ac_unit,
                    )),
              ],
            )
          : IconButton(
              splashRadius: 16,
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState!.openDrawer();
              },
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
                text: "Dash",
                color: PaletaCores.corLightGrey,
                size: 20,
                weight: FontWeight.bold),
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            splashRadius: 16,
            icon: Icon(Icons.settings,
                color: PaletaCores.corLight.withOpacity(.7)),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                  splashRadius: 16,
                  icon: Icon(
                    Icons.notifications,
                    color: PaletaCores.corLight.withOpacity(.7),
                  ),
                  onPressed: () {}),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: PaletaCores.active,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: PaletaCores.corLight, width: 2)),
                ),
              )
            ],
          ),
          Container(width: 1, height: 22, color: PaletaCores.corLightGrey),
          SizedBox(width: 24),
          CustomText(
            text: "Plataforma XPER",
            color: PaletaCores.corPrimaria,
          ),
          SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                  backgroundColor: PaletaCores.corLight,
                  child: IconButton(
                    icon:
                        Icon(Icons.person_outline, color: PaletaCores.corDark),
                    onPressed: () {
                      Get.find<ControllerProjetoRepository>().limpaTudo();
                      Get.find<AuthService>().logout();
                      Navigator.popAndPushNamed(context, "/");
                    },
                  ) //Icons.person_outline, color: PaletaCores.corDark),
                  ),
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: PaletaCores.corDark),
      backgroundColor: Colors.transparent,
    );
