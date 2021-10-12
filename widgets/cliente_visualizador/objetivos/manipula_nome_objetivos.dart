import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class ManipulaNomeObjetivo extends StatefulWidget {
  const ManipulaNomeObjetivo({Key? key}) : super(key: key);

  @override
  _ManipulaNomeObjetivoState createState() => _ManipulaNomeObjetivoState();
}

class _ManipulaNomeObjetivoState extends State<ManipulaNomeObjetivo> {
  TextEditingController _objetivoController =
      TextEditingController(text: "  Objetivo 1");
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused
    };
    const Set<MaterialState> unSelectedStates = <MaterialState>{
      MaterialState.disabled,
      MaterialState.error
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    if (states.any(unSelectedStates.contains)) {
      return Colors.red;
    }
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 360,
                  child: TextField(
                    cursorWidth: 3.0,
                    cursorHeight: 5,
                    controller: _objetivoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: controller.getObjetivos().isEmpty
                    ? false
                    : controller.objs.elementAt(0).concluido, // isChecked,
                onChanged: controller.getObjetivos().isEmpty
                    ? (bool? value) {}
                    : (bool? value) {
                        controller
                            .concluirObjetivo(controller.getObjetivos()[0]);
                      },
              )
            ],
          ),
        ),
      );
    });
  }
}
