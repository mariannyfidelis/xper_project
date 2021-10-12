import 'package:flutter/material.dart';
import '/widgets/Dashboard/routes_dash.dart';
import '/utils/paleta_cores.dart';

import 'package:get/get.dart';

class MenuControllerDash extends GetxController {
  static MenuControllerDash instance = Get.find();
  var activeItem = OverViewPageRouteDash.obs;

  var hoverItem = ''.obs;

  changeActiveitemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;

  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case AjudaPageRouteDash:
        return _customIcon(Icons.help, itemName);
      case OverViewPageRouteDash:
        return _customIcon(Icons.dashboard, itemName);
      case ObjetivosDaequipePageRouteDash:
        return _customIcon(Icons.trending_up, itemName);
      case ResultadosPageRouteDash:
        return _customIcon(Icons.list, itemName);
      case MetricasPageRouteDash:
        return _customIcon(Icons.menu_open_sharp, itemName);
      case DonosPageRouteDash:
        return _customIcon(Icons.people_alt, itemName);
      case MetasPageRouteDash:
        return _customIcon(Icons.trending_up, itemName);
      case ClientsPageRouteDash:
        return _customIcon(Icons.people, itemName);
      case CadastroADMRouteDash:
        return _customIcon(Icons.group_add, itemName);
      case ProjetoPageRouteDash:
        return _customIcon(Icons.pie_chart_rounded, itemName);
      case PlanodeAcaoPageRouteDash:
        return _customIcon(Icons.playlist_add_outlined, itemName);

      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: PaletaCores.corDark,
      );
    return Icon(
      icon,
      color:
          isHovering(itemName) ? PaletaCores.corDark : PaletaCores.corLightGrey,
    );
  }
}
