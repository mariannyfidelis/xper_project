import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/routes_dash.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/menu_dash/side_menu_item_dash.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';

class SideMenuDash extends StatelessWidget {
  const SideMenuDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: PaletaCores.corLight,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 64),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      //TODO: quando tiver logo colocar aqui.
                      child: Icon(Icons.ac_unit),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: PaletaCores.active,
                      ),
                    ),
                  ],
                )
              ],
            ),
          SizedBox(height: 40),
          Divider(color: PaletaCores.corLightGrey.withOpacity(.1)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItems
                .map((itemName) => SideMenuItemDash(
                      itemName: itemName == PlanodeAcaoPageRouteDash
                          ? "Plano de Ação"
                          : itemName,
                      onTap: () {
                        if (itemName == PlanodeAcaoPageRouteDash) {
                          //TODO: ir para authenticação
                        }
                        if (!menuControllerDash.isActive(itemName)) {
                          menuControllerDash.changeActiveitemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context))
                            Get.back();
                          navigationController.navigateTo(itemName);
                          //TODO: go to item name Route
                        }
                      },
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
