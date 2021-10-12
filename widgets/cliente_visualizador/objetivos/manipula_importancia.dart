import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/objetivo_model.dart';
import '/controllers/dados_controller.dart';

class ManipulaImportancia extends StatelessWidget {
  const ManipulaImportancia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: controller.visivel,
        child: Row(
          children: [
            Text("Importância"),
            SizedBox(width: 10),
            Text(
                "      ${controller.getObjetivos().elementAt(0).importancia.floor()}%"),
            Slider(
                value: controller.getObjetivos().elementAt(0).importancia,
                divisions: 20,
                max: 100,
                min: 0,
                activeColor: Colors.white,
                inactiveColor: Colors.transparent,
                label: "Importância",
                onChanged: (newValue) {
                  ObjetivoModel objetivo =
                      controller.getObjetivos().elementAt(0);
                  controller.changeImportancia(newValue, objetivo);
                }),
            Icon(Icons.lock_outline, size: 18)
          ],
        ),
      );
    });
  }
}
