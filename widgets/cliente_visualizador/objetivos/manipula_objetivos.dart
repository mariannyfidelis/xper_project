import 'arco_automatico_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';
import '/controllers/controller_clicado.dart';

class Objetivos extends StatefulWidget {
  Objetivos({Key? key}) : super(key: key);

  @override
  _ObjetivosState createState() => _ObjetivosState();
}

class _ObjetivosState extends State<Objetivos> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print("$width, $height");
    return Expanded(
      child: SafeArea(
        minimum: EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            print("${constraints.maxWidth}, ${constraints.maxHeight - kToolbarHeight}");
            return Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: ChangeNotifierProvider<Controller>(
                  create: (ctx) => Controller(),
                  child: Consumer<Controller>(
                      builder: (ctx, controller, child) =>
                          CanvasTouchDetector(
                            builder: (context) => CustomPaint(
                              isComplex: true,
                              willChange: true,
                              //foregroundPainter: CustomPainter(),
                              child: Container(
                                width: width,
                                height: height,
                                color: Colors.transparent,),
                              size: Size(width, height),
                              painter: ArcoAutomatico(context),
                            ),
                          ))),
            );
          },
        ),
      ),
    );
  }
}
