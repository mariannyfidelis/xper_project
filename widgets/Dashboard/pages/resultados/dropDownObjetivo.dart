import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/models/objetivosPrincipaisModel.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class DropObjetivoEResultado extends GetxController {
  var obj = "".obs;
  var result = "".obs;
  var dono = "".obs;

  atualizaObjetivoIdentificador(String s) {
    this.obj.value = s;
    refresh();
  }

  atualizaResultadoIdentificador(String s) {
    this.result.value = s;
    refresh();
  }

  atualizaDonoResultadoIdentificador(String s) {
    this.dono.value = s;
    refresh();
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
