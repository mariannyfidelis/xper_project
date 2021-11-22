import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaNomeObjetivo extends StatefulWidget {
  const ManipulaNomeObjetivo({Key? key}) : super(key: key);

  @override
  _ManipulaNomeObjetivoState createState() => _ManipulaNomeObjetivoState();
}

class _ManipulaNomeObjetivoState extends State<ManipulaNomeObjetivo> {
  var mandalaController = Get.find<ControllerProjetoRepository>();

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
    return Visibility(
      visible: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Expanded(     child:
              Container(
                padding: EdgeInsets.only(right: 30),
                width: 360,
                child: Obx(
                  ()=> TextField(
                    enabled: mandalaController.editor.value,
                    enableInteractiveSelection: mandalaController.editor.value,
                    cursorColor: PaletaCores.textColor,
                    style: TextStyle(color: PaletaCores.textColor),
                    cursorWidth: 3.0,
                    cursorHeight: 5,
                    controller: mandalaController.objetivoController,
                    onChanged: (text) {
                      if(mandalaController.acl() == true){
                      mandalaController.atualizarNome(text);
                      }
                    },
                    decoration: InputDecoration(
                      focusColor: PaletaCores.textColor,
                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
            //),
            //SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
