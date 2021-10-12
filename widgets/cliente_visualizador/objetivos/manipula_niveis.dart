import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/controllers/dados_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManipulaNiveisPrimarios extends StatefulWidget {
  ManipulaNiveisPrimarios({Key? key}) : super(key: key);
  @override
  _ManipulaNiveisPrimariosState createState() =>
      _ManipulaNiveisPrimariosState();
}

class _ManipulaNiveisPrimariosState extends State<ManipulaNiveisPrimarios> {
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ObjectiveController>(context, listen: false);

    return Visibility(
      visible: true,
      child: Row(
        children: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              controller.addObjetivo();
            },
            icon: Icon(FontAwesomeIcons.plusSquare), //(Icons.add),
          ),
          SizedBox(width: 2),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              controller.delObjetivo();
            },
            icon: Icon(FontAwesomeIcons.minusSquare),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              controller.addObjetivoProximo();
              // setState(() {
              //   if (objetictive >= 1) {
              //     objetictive = objetictive - 1;
              //     p = (100 / objetictive);
              //     graus = (360 * p) / 100;
              //     niveis = niveis - 1;

              //   }
              // });
            },
            tooltip: "Objetivo próximo - adicionar",
            icon: Icon(FontAwesomeIcons.plusCircle),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () {
              controller.delObjetivoProximo();
              // setState(() {
              //   if (objetictive >= 1) {
              //     objetictive = objetictive - 1;
              //     p = (100 / objetictive);
              //     graus = (360 * p) / 100;
              //     niveis = niveis - 1;
              //     criaPaint(lsPaint, true);
              //   }
              // });
            },
            tooltip: "Objetivo próximo - deletar",
            icon: Icon(FontAwesomeIcons.minusCircle),
          ),
          PopupMenuButton(
            tooltip: "Menu de objetivos",
            initialValue: 9,
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
                      Text('Excluir objetivo')
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
}
