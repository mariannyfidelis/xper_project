import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({Key? key}) : super(key: key);

  @override
  _TelaCalendarioState createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  String _dataVencimento = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectiveController>(
        builder: (context, controller, widget) {
      return Visibility(
        visible: controller.visivel,
        child: Row(
          children: [
            Text("Vencimento      "),
            IconButton(
              splashRadius: 15,
              iconSize: 20,
              onPressed: () {
                //Mudança de estado da data de Vencimento
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2025, 12, 25))
                    .then((value) {
                  //print("Data vencimento - ${value!.day.toString()}");
                  _dataVencimento =
                      "${value!.day}/${value.month}/${value.year}";
                  print("Data vencimento - $_dataVencimento");
                  controller.changeDataVencimento(
                      value, controller.getObjetivos().first);
                });
              },
              icon: Icon(Icons.date_range
                  //size: 15
                  ),
            ),
            SizedBox(width: 12),
            Text(
              "${controller.objs[0].dataFormatada}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      );
    });
  }
}
