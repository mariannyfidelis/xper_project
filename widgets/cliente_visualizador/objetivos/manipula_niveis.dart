import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaOKR extends StatefulWidget {
  ManipulaOKR({Key? key}) : super(key: key);
  @override
  _ManipulaOKRState createState() => _ManipulaOKRState();
}

class _ManipulaOKRState extends State<ManipulaOKR> {
  var mandalaController = Get.find<ControllerProjetoRepository>();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Row(
        children: [
          ElevatedButton(
              onPressed: adicionaObjetivo,
              child: Text(
                "Novo Objetivo",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )),
          SizedBox(width: 20),
          ElevatedButton(
              onPressed: adicionaResultado,
              child: Text(
                "Novo Resultado",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )),
          SizedBox(width: 20),
          ElevatedButton(
              onPressed: adicionaMetrica,
              child: Text(
                "Nova Métrica",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              )),

          PopupMenuButton(
            tooltip: "Menu de objetivos",
            initialValue: 9,
            onSelected: ((value) {
              if (value == 2) {
                (mandalaController.ultimoNivelClicado.value == 2)
                    ? mandalaController.removeObjetivo(
                        mandalaController.ultimoObjetivoClicado.value)
                    : mandalaController.removeResultado(
                        mandalaController.ultimoResultadoClicado.value);
              }
            }),
            child: Center(child: Icon(Icons.arrow_drop_down)),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.cut),
                      SizedBox(width: 16),
                      Text('Cortar objetivo'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.copy),
                      SizedBox(width: 16),
                      Text('Copiar objetivo'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.all(5),
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.remove_circle),
                      SizedBox(width: 16),
                      Text('Excluir objetivo'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.color_lens),
                          SizedBox(width: 16),
                          Text('Colorir objetivo'),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 4,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.mark_as_unread),
                      SizedBox(width: 16),
                      Text('Marcar objetivo'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 5,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.font_download),
                      SizedBox(width: 16),
                      Text('Aumentar fonte'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 6,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.font_download_off),
                      SizedBox(width: 16),
                      Text('Diminuir fonte'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 7,
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Divider(),
                      Row(
                        children: [
                          Icon(Icons.graphic_eq),
                          SizedBox(width: 16),
                          Text('Igualar objetivos secundários'),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 8,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.equalizer),
                      SizedBox(width: 16),
                      Text('Progresso completo'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 9,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(Icons.center_focus_strong),
                      SizedBox(width: 16),
                      Text('Foco no objetivo'),
                    ],
                  ),
                )
              ];
            },
          )
        ],
      ),
    );
  }

  void adicionaObjetivo() {
    debugPrint("||| Adicionando um novo objetivo ...");
    mandalaController.addOneObjective(
        "Novo objetivo ${mandalaController.listaObjectives.length + 1}");
  }

  void adicionaResultado() {
    if (mandalaController.ultimoObjetivoClicado.value != '') {
      debugPrint("||| Adicionando um novo resultado ...");
      mandalaController.addOneResultado(
          "Novo resultado ${mandalaController.listaResultados.length + 1}",
          idObjetivoPai: mandalaController.ultimoObjetivoClicado.value);
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text("Nenhum Objetivo Selecionado"),
                  content: Text(
                      "Selecione algum objetivo para adicionar um resultado"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("OK")),
                  ]));
    }
  }

  void adicionaMetrica() {
    if (mandalaController.ultimoResultadoClicado.value != '') {
      debugPrint("||| Adicionando uma nova métrica ...");
      mandalaController.addOneMetric(
          "Nova métrica ${mandalaController.listaMetricas.length + 1} do ${mandalaController.nomeResultMandala}",
          idResultado: mandalaController.ultimoResultadoClicado.value);
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text("Nenhum Resultado Selecionado"),
                  content: Text(
                      "Selecione algum resultado para adicionar uma métrica"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("OK")),
                  ]));
    }
  }
}
