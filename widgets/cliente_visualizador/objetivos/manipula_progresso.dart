import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
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
              Text("Progresso Atual   ", style: TextStyle(color: PaletaCores.textColor)),
              SizedBox(width: 10),
              Text(
                  "${(mandalaController.ultimoNivelClicado.value == 2) ? mandalaController.progressoAtualObj.value.floor() : mandalaController.progressoAtualResult.value.floor()}%",
                  style: TextStyle(color: PaletaCores.textColor)),
              Slider(

                  value: (mandalaController.ultimoNivelClicado.value == 2)
                      ? (mandalaController.progressoAtualObj.value <= 100)
                      ? mandalaController.progressoAtualObj.value
                      : 100
                      : (mandalaController.progressoAtualResult.value <= 100)
                      ? mandalaController.progressoAtualResult.value
                      : 100,
                divisions: 20,
                max: 100,
                min: 0,
                activeColor: PaletaCores.textColor,
                inactiveColor: Colors.transparent,
                //inactiveColor: Colors.red,
                label: "Progresso",
                onChanged: (newValue) {
                  newValue = mandalaController.progressoObj.value;
                },
              ),
              IconButton(
                color: PaletaCores.textColor,
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
              Text("Progresso Geral   ", style: TextStyle(color: PaletaCores.textColor)),
              SizedBox(width: 10),
              Text(
                  "${(mandalaController.ultimoNivelClicado.value == 2) ? mandalaController.progressoObj.value.floor() : mandalaController.progressoResult.value.floor()}%",
                  style: TextStyle(color: PaletaCores.textColor)),
              Slider(
                value: (mandalaController.ultimoNivelClicado.value == 2)
                    ? (mandalaController.progressoObj.value >= 100)
                    ? 100
                    : mandalaController.progressoObj.value
                    : (mandalaController.progressoResult.value >= 100)
                    ? 100
                    : mandalaController.progressoResult.value,
                divisions: 20,
                max: 100,
                min: 0,
                activeColor: PaletaCores.textColor,
                inactiveColor: Colors.transparent,
                //inactiveColor: Colors.red,
                label: "Progresso",
                onChanged: (newValue) {
                  newValue = mandalaController.progressoObj.value;
                },
              ),
              IconButton(
                color: PaletaCores.textColor,
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