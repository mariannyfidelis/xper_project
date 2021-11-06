import '/utils/breakpoints.dart';
import 'package:flutter/material.dart';
import '/screens/meta_cliente_page.dart';
import '/widgets/cliente_visualizador/appbar/appBarWeb.dart';
import '/widgets/cliente_visualizador/drawer/drawerWeb.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '/widgets/cliente_visualizador/appbar/appBarMobile.dart';
import '/widgets/cliente_visualizador/drawer/drawerMobile.dart';
import '../widgets/cliente_visualizador/objetivos/calendario.dart';
import '/widgets/cliente_visualizador/objetivos/manipula_extensoes.dart';
import '/widgets/cliente_visualizador/card_edicao_notas/edicao_notas.dart';
import '../widgets/cliente_visualizador/objetivos/manipula_objetivos.dart';
import '../widgets/cliente_visualizador/objetivos/manipula_progresso.dart';
import '/widgets/cliente_visualizador/objetivos/manipula_responsaveis.dart';
import '../widgets/cliente_visualizador/objetivos/mostra_oculta_detalhes.dart';
import '../widgets/cliente_visualizador/objetivos/manipula_nome_objetivos.dart';

class ProjetoPage extends StatefulWidget {
  const ProjetoPage({Key? key}) : super(key: key);

  @override
  _ProjetoPageState createState() => _ProjetoPageState();
}

class _ProjetoPageState extends State<ProjetoPage> {
  Color currentColor = Colors.limeAccent;
  Color color = Colors.red;

  @override

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: constraints.maxWidth < mobile_breakpoint
              ? PreferredSize(
                  child: MobileAppBar(),
                  preferredSize: Size(double.infinity, 50))
              : PreferredSize(
                  child: WebAppBar(),
                  preferredSize: Size(double.infinity, 50),
                ),
          drawer: constraints.maxWidth < mobile_breakpoint
              ? DrawerMobile()
              : DrawerWeb(),
          body: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                //minHeight: 1000,
                //minWidth: 1500,
                maxWidth: 1700, /*maxHeight: 900*/
              ),
              child: Container(
                color: Color.fromRGBO(56, 56, 56, 1), //  Colors.blueGrey,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Objetivos(),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tight(Size(500, double.infinity)),
                      child: LayoutBuilder(
                        builder: (_, constraints) {
                          return Card(
                            margin: EdgeInsets.all(12),
                            color: Colors.grey[800],
                            shadowColor: Colors.grey[600],
                            elevation: 22,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  ManipulaNomeObjetivo(),
                                  ManipulaProgresso(),
                                  ManipulaResponsaveis(),
                                  ManipulaExtensoes(),
                                  TelaCalendario(),
                                  TelaMeta(),
                                  OutlinedButton.icon(
                                    onPressed: escolhaCorObjetivoResultado2,
                                    icon: Icon(Icons.color_lens_outlined),
                                    label: Text("Escolha uma cor"),
                                  ),
                                  TelaDetalhes(),
                                  EdicaoNotas(),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                              ),
                            ),
                          );
                        },
                      ),
                    ), //*/
                    //EdicaoNotas()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void changeColor(Color color) => setState(() => currentColor = color);

  escolhaCorObjetivoResultado2(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            actionsPadding: const EdgeInsets.all(0.0),
            buttonPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            content: ColorPicker(
            pickerColor: color,
            onColorChanged: (color)=> setState(()=> this.color=color),
          ),
          );
        });
  }
  escolhaCorObjetivoResultado() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            content: SingleChildScrollView(
              child: SlidePicker(
                pickerColor: currentColor,
                onColorChanged: changeColor,
                paletteType: PaletteType.rgb,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
                showIndicator: true,
                indicatorBorderRadius: const BorderRadius.vertical(
                  top: const Radius.circular(25.0),
                ),
              ),
            ),
          );
        });
  }
}
