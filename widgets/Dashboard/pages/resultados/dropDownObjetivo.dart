import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/models/objetivosPrincipaisModel.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class DropObjetivoEResultado extends GetxController {
  var obj = "".obs;
  var result = "".obs;

  atualizaObjetivoIdentificador(String s) {
    debugPrint("Valor que veio pro controller objetivo drop: $s");
    this.obj.value = s;
    debugPrint("Valor que saiu objetivo: ${this.obj.value} - $obj");
    refresh();
    debugPrint("Valor que saiu depois do refresh: ${this.obj.value} - $obj");
  }

  atualizaResultadoIdentificador(String s) {
    debugPrint("Valor que veio pro controller resultado drop: $s");
    this.result.value = s;
    debugPrint("Valor que saiu result: ${this.result.value} - $result");
    refresh();
    debugPrint("Valor que saiu depois do refresh: ${this.result.value} - $result");
  }
}

class DropDownObjetivo extends StatefulWidget {
  @override
  _DropDownObjetivoState createState() => _DropDownObjetivoState();
}

class _DropDownObjetivoState extends State<DropDownObjetivo> {
  //ObjetivosPrincipais? objetivo;

  var controllerProjeto = Get.find<ControllerProjetoRepository>();
  var _objetivoSelecionado = (Get.find<ControllerProjetoRepository>()
          .listaObjectives
          .isEmpty)
      ? null
      : Get.find<ControllerProjetoRepository>().listaObjectives.elementAt(0);

  @override
  Widget build(BuildContext context) {
    var _objetivos = controllerProjeto.listaObjectives;
    var testeDrop = Get.find<DropObjetivoEResultado>();

    return _objetivoSelecionado != null
        ? Container(
            child: Column(
              children: <Widget>[
                DropdownButton<ObjetivosPrincipais>(
                  items:
                      _objetivos.map((ObjetivosPrincipais dropDownStringItem) {
                    return DropdownMenuItem<ObjetivosPrincipais>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem.nome.toString()),
                    );
                  }).toList(),
                  onChanged: (ObjetivosPrincipais? novoItemSelecionado) {
                    _dropDownItemSelected(novoItemSelecionado!);
                    setState(() {
                      _objetivoSelecionado = novoItemSelecionado;
                      testeDrop.atualizaObjetivoIdentificador(
                          _objetivoSelecionado!.idObjetivo!);
                    });
                  },
                  value: _objetivoSelecionado,
                ),
                Text(
                  "O objetivo selecionado foi \n${_objetivoSelecionado!.nome} - id [${_objetivoSelecionado!.idObjetivo}]",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          )
        : Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              "Adicione primeiramente os objetivos do projeto",
              style: TextStyle(
                  color: PaletaCores.corPrimaria, fontWeight: FontWeight.bold),
            ),
          ));
  }

  void _dropDownItemSelected(ObjetivosPrincipais novoItem) {
    setState(() {
      _objetivoSelecionado = novoItem;
    });
  }
}
