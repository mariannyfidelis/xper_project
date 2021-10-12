import 'package:flutter/material.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';

import '/utils/paleta_cores.dart';

class InfoCardSmallDash extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? topColor;
  final bool? isActive;
  final Function()? onTap;

  const InfoCardSmallDash(
      {Key? key,
      this.title,
      this.value,
      this.topColor,
      this.isActive = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color:
                      isActive! ? PaletaCores.active : PaletaCores.corLightGrey,
                  width: .5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: title,
                  size: 24,
                  weight: FontWeight.w300,
                  color: isActive!
                      ? PaletaCores.active
                      : PaletaCores.corLightGrey),
              CustomText(
                text: value,
                size: 24,
                weight: FontWeight.bold,
                color:
                    isActive! ? PaletaCores.active : PaletaCores.corLightGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
