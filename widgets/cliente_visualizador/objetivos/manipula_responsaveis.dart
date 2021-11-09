import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaResponsaveis extends StatelessWidget {
  const ManipulaResponsaveis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mandalaController = Get.find<ControllerProjetoRepository>();
    return Obx(
          () => Visibility(
        visible: mandalaController.visivel.value,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Responsáveis"),
                SizedBox(
                  width: 20,
                ),
                Container(
                    width: 250,
                    child: TextField(
                      textAlign: TextAlign.justify,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.people,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      maxLength: 450,
                      keyboardType: TextInputType.text,
                    )),
                IconButton(
                    splashRadius: 15,
                    onPressed: mandalaController.adicionarResponsavel,
                    icon: Icon(Icons.add, size: 20)),
                IconButton(
                    splashRadius: 15,
                    onPressed: mandalaController.buscarResponsavel,
                    icon: Icon(Icons.search, size: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}