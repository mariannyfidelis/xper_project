import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({Key? key}) : super(key: key);

  @override
  _TelaCalendarioState createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  var mandalaController = Get.find<ControllerProjetoRepository>();
  String _dataVencimento = "";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: mandalaController.visivel.value,
        child: Row(
          children: [
            Text("Vencimento      "),
            IconButton(
              splashRadius: 15,
              iconSize: 20,
              onPressed: () {
                //Mudança de estado da data de Vencimento
                (mandalaController.indiceObjective.value != -1)
                    ? showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025, 12, 25))
                        .then((value) {
                        //print("Data vencimento - ${value!.day.toString()}");
                        _dataVencimento =
                            "${value!.day}/${value.month}/${value.year}";
                        print("Data vencimento - $_dataVencimento");
                        mandalaController.changeDataVencimento(
                            Timestamp.fromDate(value),
                            mandalaController.listaObjectives[
                                mandalaController.indiceObjective.value]);
                      })
                    // ignore: unnecessary_statements
                    : () {};
              },
              icon: Icon(Icons.date_range
                  //size: 15
                  ),
            ),
            SizedBox(width: 12),
            Obx(() => Text(
                  (mandalaController.listaObjectives.length > 0 &&
                          mandalaController.indiceObjective.value != -1)
                      ? "${mandalaController.listaObjectives[mandalaController.indiceObjective.value].dataFormatada}"
                      : "",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
