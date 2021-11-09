import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaNomeObjetivo extends StatefulWidget {
  const ManipulaNomeObjetivo({Key? key}) : super(key: key);

  @override
  _ManipulaNomeObjetivoState createState() => _ManipulaNomeObjetivoState();
}

class _ManipulaNomeObjetivoState extends State<ManipulaNomeObjetivo> {
  var mandalaController = Get.find<ControllerProjetoRepository>();

  // TextEditingController _objetivoController = TextEditingController(
  //     /*text: (Get.find<ControllerProjetoRepository>().ultimoNivelClicado.value <=
  //             2)
  //         ? (Get.find<ControllerProjetoRepository>().ultimoNivelClicado.value ==
  //                 2)
  //             ? Get.find<ControllerProjetoRepository>().nomeObjMandala.value
  //             : Get.find<ControllerProjetoRepository>().nome.value
  //         : Get.find<ControllerProjetoRepository>().nomeResultMandala.value*/);

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
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 360,
                child: Obx(() => TextField(
                  cursorWidth: 3.0,
                  cursorHeight: 5,
                  controller: mandalaController.objetivoController,
                  onChanged: (text) {
                    //mandalaController.mudaNome(text);
                    mandalaController.atualizaPedaco(text);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                )),
              ),
            ),
            SizedBox(width: 10),
            // ElevatedButton(
            //     onPressed: () {
            //       mandalaController.atualizaPedaco(
            //           mandalaController.objetivoController.value.text);
            //     },
            //     child: Text(
            //       "atualiza okr",
            //       style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            //     )),
            SizedBox(width: 20),
            // Checkbox(
            //   checkColor: Colors.white,
            //   fillColor: MaterialStateProperty.resolveWith(getColor),
            //   value: mandalaController.listaObjectives.isEmpty
            //       ? false
            //       : controller.objs.elementAt(0).concluido, // isChecked,
            //   onChanged: mandalaController.listaObjectives.isEmpty
            //       ? (bool? value) {}
            //       : (bool? value) {
            //          mandalaController
            //               .concluirObjetivo(mandalaController.listaObjectives[0]);
            //         },
            // )
          ],
        ),
      ),
    );
  }
}
