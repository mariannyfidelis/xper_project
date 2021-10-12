import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class TelaDetalhes extends StatelessWidget {
  const TelaDetalhes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            child: GestureDetector(
              onTap: () => controller.changeVisibilidade(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${controller.detalhes}"),
                  SizedBox(width: 10),
                  Icon(controller.iconDetalhes)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
