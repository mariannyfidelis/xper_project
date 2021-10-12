import 'package:flutter/material.dart';
import '/utils/paleta_cores.dart';

class InfoCardDash extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? topColor;
  final bool? isActive;
  final Function()? onTap;

  const InfoCardDash(
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
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: PaletaCores.active.withOpacity(.33), //cor do card
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    color: PaletaCores.corLightGrey.withOpacity(.1),
                    blurRadius: 12),
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        color: topColor ?? PaletaCores.active, height: 5),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: TextStyle(
                          fontSize: 16,
                          color: isActive!
                              ? PaletaCores.corLight
                              : PaletaCores.corLight),
                    ),
                    TextSpan(
                      text: '$value\n',
                      style: TextStyle(
                          fontSize: 40,
                          color: isActive!
                              ? PaletaCores.corLight
                              : PaletaCores.corLight),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
