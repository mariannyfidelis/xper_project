import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xper_brasil_projects/widgets/Dashboard/controller/controllers_dash.dart';
import '/utils/configuracoes_aplicacao.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String permissao = "";
  var _permissao = ['pode ler', 'pode editar'];
  var _itemSelecionado = 'pode ler';

  @override
  Widget build(BuildContext context) {
    return criaDropDownButton();
  }

  criaDropDownButton() {
    return Obx(()=> Container(
      child: DropdownButton<String>(
        items: _permissao.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(
              dropDownStringItem,
              style: estiloTextoBotaoDropMenuButton,
            ),
          );
        }).toList(),
        onChanged: (String? novoItemSelecionado) {
          _dropDownItemSelected(novoItemSelecionado.toString());
        },
        value: Get.find<ControllerProjetoRepository>().permissaoCompartilhar.string,
      ),
    ));
  }

  void _dropDownItemSelected(String novoItem) {
    Get.find<ControllerProjetoRepository>().changePermissaoCompartilhar(novoItem);
      //this._itemSelecionado = novoItem;

  }
}
