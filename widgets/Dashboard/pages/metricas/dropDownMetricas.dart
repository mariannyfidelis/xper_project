import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/models/resultadoPrincipalModel.dart';
import '/models/donoResultadoMetricaModel.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/pages/resultados/dropDownObjetivo.dart';

class DropDownMetrica extends StatefulWidget {
  @override
  _DropDownMetricaState createState() => _DropDownMetricaState();
}

class _DropDownMetricaState extends State<DropDownMetrica> {

  var controllerProjeto = Get.find<ControllerProjetoRepository>();
  var _resultadoSelecionado;

  @override
  Widget build(BuildContext context) {

    setResultadoSelecionado();

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

  void setResultadoSelecionado() {
    setState(() {
      _resultadoSelecionado = (Get.find<ControllerProjetoRepository>()
          .listaResultados
          .isEmpty)
          ? null
          : Get.find<ControllerProjetoRepository>().listaResultados.elementAt(0);
    });
  }

  void _dropDownItemSelected(ResultadosPrincipais novoItem) {
    setState(() {
      _resultadoSelecionado = novoItem;
    });
  }

}


class DropDownDonoResultadometrica extends StatefulWidget {
  const DropDownDonoResultadometrica({Key? key}) : super(key: key);

  @override
  _DropDownDonoResultadometricaState createState() => _DropDownDonoResultadometricaState();
}

class _DropDownDonoResultadometricaState extends State<DropDownDonoResultadometrica> {
  var controllerProjeto = Get.find<ControllerProjetoRepository>();
  var _donoresultadoSelecionado = (Get.find<ControllerProjetoRepository>()
      .listaDonos
      .isEmpty)
      ? null
      : Get.find<ControllerProjetoRepository>().listaDonos.elementAt(0);

  //TextEditingController donoController = TextEditingController();
  //var selectDono = "";

  @override
  Widget build(BuildContext context) {
    var _donos_resultados = Get.find<ControllerProjetoRepository>().listaDonos;
    var testeDrop = Get.find<DropObjetivoEResultado>();

    return _donoresultadoSelecionado != null
        ? Container(
      child: Column(
        children: <Widget>[
          DropdownButton<DonosResultadoMetricas>(
            items: _donos_resultados
                .map((DonosResultadoMetricas dropDownStringItem) {
              return DropdownMenuItem<DonosResultadoMetricas>(
                value: dropDownStringItem,
                child: Text("${dropDownStringItem.nome.toString()} - ${dropDownStringItem.email.toString()}"),
              );
            }).toList(),
            onChanged: (DonosResultadoMetricas? novoItemSelecionado) {
              _dropDownItemSelected(novoItemSelecionado!);
              setState(() {
                _donoresultadoSelecionado = novoItemSelecionado;
                testeDrop.atualizaDonoResultadoIdentificador(
                    _donoresultadoSelecionado!.id!);
              });
            },
            value: _donoresultadoSelecionado,
          ),
          Text(
            "O dono selecionado para o resultado foi \n${_donoresultadoSelecionado!.nome} - id [${_donoresultadoSelecionado!.id}]",
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    )
        : Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text(
            "Adicione primeiramente os resultados do projeto. E só depois vincule um dono a uma resultado",
            style: TextStyle(
                color: PaletaCores.corPrimaria, fontWeight: FontWeight.bold),
          ),
        ));
  }

  void _dropDownItemSelected(DonosResultadoMetricas novoItem) {
    setState(() {
      _donoresultadoSelecionado = novoItem;
    });
  }
}
