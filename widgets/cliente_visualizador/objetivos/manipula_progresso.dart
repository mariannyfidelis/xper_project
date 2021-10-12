import '/models/objetivo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class ManipulaProgresso extends StatelessWidget {
  const ManipulaProgresso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: controller.visivel,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Progresso    "),
            SizedBox(width: 10),
            Text(
                "      ${controller.getObjetivos().elementAt(0).progresso.floor()}%"),
            Slider(
              value: controller.getObjetivos().elementAt(0).progresso,
              divisions: 20,
              max: 100,
              min: 0,
              activeColor: Colors.white,
              inactiveColor: Colors.transparent,
              //inactiveColor: Colors.red,
              label: "Progresso",
              onChanged: (newValue) {
                ObjetivoModel objetivo = controller.getObjetivos().elementAt(0);
                controller.changeProgresso(newValue, objetivo);
              },
            ),
            Icon(Icons.lock_outline, size: 18),
          ],
        ),
      );
    });
  }
}
