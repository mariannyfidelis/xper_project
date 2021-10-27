import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/models/resultadoPrincipalModel.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/pages/resultados/dropDownObjetivo.dart';

class DropDownMetrica extends StatefulWidget {
  @override
  _DropDownMetricaState createState() => _DropDownMetricaState();
}

class _DropDownMetricaState extends State<DropDownMetrica> {
  //ResultadosPrincipais? resultado;

  var controllerProjeto = Get.find<ControllerProjetoRepository>();
  var _resultadoSelecionado = (Get.find<ControllerProjetoRepository>()
          .listaResultados
          .isEmpty)
      ? null
      : Get.find<ControllerProjetoRepository>().listaResultados.elementAt(0);

  @override
  Widget build(BuildContext context) {
    var _resultados = Get.find<ControllerProjetoRepository>().listaResultados;
    var testeDrop = Get.find<DropObjetivoEResultado>();

    return _resultadoSelecionado != null
        ? Container(
            child: Column(
              children: <Widget>[
                DropdownButton<ResultadosPrincipais>(
                  items: _resultados
                      .map((ResultadosPrincipais dropDownStringItem) {
                    return DropdownMenuItem<ResultadosPrincipais>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem.nomeResultado.toString()),
                    );
                  }).toList(),
                  onChanged: (ResultadosPrincipais? novoItemSelecionado) {
                    _dropDownItemSelected(novoItemSelecionado!);
                    setState(() {
                      _resultadoSelecionado = novoItemSelecionado;
                      testeDrop.atualizaResultadoIdentificador(
                          _resultadoSelecionado!.idResultado!);
                    });
                  },
                  value: _resultadoSelecionado,
                ),
                Text(
                  "O resultado selecionado foi \n${_resultadoSelecionado!.nomeResultado} - id [${_resultadoSelecionado!.idResultado}]",
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          )
        : Container(
            child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
            child: Text(
              "Adicione primeiramente os resultados do projeto. E só depois vincule uma métrica",
              style: TextStyle(
                  color: PaletaCores.corPrimaria, fontWeight: FontWeight.bold),
            ),
          ));
  }

  void _dropDownItemSelected(ResultadosPrincipais novoItem) {
    setState(() {
      _resultadoSelecionado = novoItem;
    });
  }
}
