import 'vertical_menu_dash.dart';
import 'horizontal_menu_dash.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/responsividade/reposinvidade_dash.dart';

class SideMenuItemDash extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;

  const SideMenuItemDash({Key? key, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context))
      return VerticalMenuItemDash(itemName: itemName, onTap: onTap);
    return HorizontalMenuItemDash(itemName: itemName, onTap: onTap);
  }
}
