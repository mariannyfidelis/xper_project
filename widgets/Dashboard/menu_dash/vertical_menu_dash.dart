import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class VerticalMenuItemDash extends StatelessWidget {
  final String? itemName;
  final Function()? onTap;

  const VerticalMenuItemDash({Key? key, this.itemName, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuControllerDash.onHover(itemName!)
            : menuControllerDash.onHover('not hovering');
      },
      child: Obx(
        () => Container(
          color: menuControllerDash.isHovering(itemName!)
              ? PaletaCores.corLightGrey.withOpacity(.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuControllerDash.isHovering(itemName!) ||
                    menuControllerDash.isActive(itemName!),
                child:
                    Container(width: 3, height: 72, color: PaletaCores.corDark),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: menuControllerDash.returnIconFor(itemName!),
                  ),
                  if (!menuControllerDash.isActive(itemName!))
                    Flexible(
                      child: CustomText(
                          text: itemName!,
                          color: menuControllerDash.isHovering(itemName!)
                              ? PaletaCores.corDark
                              : PaletaCores.corLightGrey),
                    )
                  else
                    Flexible(
                      child: CustomText(
                        text: itemName,
                        color: PaletaCores.corDark,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
