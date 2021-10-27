import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  String nomeCidade="";
  var _cidades =['Santos','Porto Alegre','Campinas','Rio de Janeiro'];
  var _itemSelecionado = 'Santos';

  @override
  Widget build(BuildContext context) {
    return criaDropDownButton();
  }

  criaDropDownButton() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Selecione a cidade"),
          TextField(
            onSubmitted: (String userInput) {
              setState(() {
                debugPrint('chamei setState');
                nomeCidade = userInput;
              });
            },
          ),
          DropdownButton<String>(
            items : _cidades.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: ( String? novoItemSelecionado) {
              _dropDownItemSelected(novoItemSelecionado.toString());
              setState(() {
                this._itemSelecionado =  novoItemSelecionado!;
              });
            },
            value: _itemSelecionado,
          ),
          Text("A cidade selecionada foi \n$_itemSelecionado",
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
  void _dropDownItemSelected(String novoItem){
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }
}