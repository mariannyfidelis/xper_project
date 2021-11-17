import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '/utils/paleta_cores.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ManipulaCor extends StatefulWidget {
  const ManipulaCor({Key? key}) : super(key: key);

  @override
  _ManipulaCorState createState() => _ManipulaCorState();
}

class _ManipulaCorState extends State<ManipulaCor> {
  Color color = Colors.red;
  Color currentColor = Colors.limeAccent;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: escolhaCorObjetivoResultado2,
      icon: Icon(Icons.color_lens_outlined),
      label: Text("Escolha uma cor"),
    );
  }

  escolhaCorObjetivoResultado2() {
    var mandalaController = Get.find<ControllerProjetoRepository>();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Escolha uma cor"),
            elevation: 10,
            scrollable: false,
            titlePadding: const EdgeInsets.only(top: 20.0, left: 20.0),
            contentPadding: const EdgeInsets.all(0.0),
            actionsPadding: const EdgeInsets.all(0.0),
            buttonPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            content: Container(
              height: 300,
              width: 600,
              child: Column(children: [
                ColorPicker(
                    colorPickerWidth: 400,
                    portraitOnly: false,
                    pickerAreaHeightPercent: 0.6,
                    pickerColor: color,
                    onColorChanged: (Color color) {
                      setState(() {
                        this.color = color;
                      });
                    }),
                SizedBox(height: 26),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: PaletaCores.active, width: .5),
                      color: PaletaCores.corLight,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: TextButton(
                      child:
                          Text('Salvar', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        mandalaController.atualizaCor(
                            "${color.alpha}-${color.red}-${color.green}-${color.blue}");
                        Get.back();
                      }),
                )
              ]),
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

  void changeColor(Color color) => setState(() => currentColor = color);
}
