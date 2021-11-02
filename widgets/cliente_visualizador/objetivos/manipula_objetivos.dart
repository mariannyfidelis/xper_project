import 'package:get/get.dart';

import 'arco_automatico_painter.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

class Objetivos extends StatefulWidget {
  Objetivos({Key? key}) : super(key: key);

  @override
  _ObjetivosState createState() => _ObjetivosState();
}

class _ObjetivosState extends State<Objetivos> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - kToolbarHeight;

    return Expanded(
      child: SafeArea(
        minimum: EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(78.0),
          child: CanvasTouchDetector(
            builder: (context) => CustomPaint(
              size: Size(
                  width,
                  (height * 0.87833333333333334)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: ArcoAutomatico(context),
            ),
          ),
        ),
      ),
    );
  }
}
