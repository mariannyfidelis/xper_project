import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaProgresso extends StatelessWidget {
  const ManipulaProgresso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mandalaController = Get.find<ControllerProjetoRepository>();

    return Obx(() => Visibility(
      visible: mandalaController.visivel.value,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Progresso             "),
              SizedBox(width: 10),
              Text("${mandalaController.progressoObj.floor()}%"),
              Slider(
                value: mandalaController.progressoObj.value,
                divisions: 20,
                max: 100,
                min: 0,
                activeColor: Colors.white,
                inactiveColor: Colors.transparent,
                //inactiveColor: Colors.red,
                label: "Progresso",
                onChanged: (newValue) {
                  newValue = mandalaController.progressoObj.value;
                },
              ),
              IconButton(
                icon: Icon(Icons.lock_outline, size: 18),
                onPressed: () {
                  mandalaController.atualizaObjetivoMandala(
                      mandalaController.ultimoObjetivoClicado.value,
                      progresso: mandalaController.progressoObj.value);
                },
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Progresso Geral   "),
              SizedBox(width: 10),
              Text("${mandalaController.progressoObj.floor()}%"),
              Slider(
                value: mandalaController.progressoObj.value,
                divisions: 20,
                max: 100,
                min: 0,
                activeColor: Colors.white,
                inactiveColor: Colors.transparent,
                //inactiveColor: Colors.red,
                label: "Progresso",
                onChanged: (newValue) {
                  newValue = mandalaController.progressoObj.value;
                },
              ),
              IconButton(
                icon: Icon(Icons.lock_outline, size: 18),
                onPressed: () {
                  mandalaController.atualizaObjetivoMandala(
                      mandalaController.ultimoObjetivoClicado.value,
                      progresso: mandalaController.progressoObj.value);
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}