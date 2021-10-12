import 'package:flutter/material.dart';
import '/widgets/cliente_visualizador/objetivos/editor_zefyr.dart';

class EdicaoNotas extends StatelessWidget {
  const EdicaoNotas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 8),
          child: Container(width: 550, child: EditorNotas()
              /*Card(
              elevation: 30,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Colors.blueGrey,
              child: _dateTime == null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("Nada de data ainda ..."),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("${_dateTime.toString()}"),
                    ),
            ),*/
              ),
        ),
      ),
    );
  }
}
