import 'dart:ui';
import 'dart:math';
import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import '/controllers/controller_clicado.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ArcoAutomatico extends CustomPainter {
  BuildContext context;
  final Controller controller;

  ArcoAutomatico(this.context): controller = Provider.of<Controller>(context, listen: false);

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  void drawObject(TouchyCanvas canvas, Canvas cv, Size size) {
    double width = size.width / 2;
    double height = size.height / 2;
    final c = Offset(width, height);
    final radius = size.width * 0.67;
    var controlador_clicado = Provider.of<Controller>(context, listen: false);

    final linePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final styleText2 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25.0,
    );

    final styleTextObjectiveWithoutResult = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 40.0,
    );

    final styleTextObjectiveWithResult = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 45.0,
    );

    final styleTextResult = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 30.0,
    );

    final styleText3 = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 50.0,
    );

    var mandalaController = Get.find<ControllerProjetoRepository>();
    int numeroDeObjetivos = mandalaController.listaObjectives.length;
    var listaObjetivos = mandalaController.listaObjectives;
    int numeroDeResultados = mandalaController.listaResultados.length;

    Rect oval;
    Rect rectObjetivos;
    Rect rectResultados;

    List<Path> listPathObjetivos = [];
    List<Path> listPathResultados = [];
    List<Paint> listPaintObjetivos = [];
    List<Paint> listPaintResultados = [];

    double anguloInicio = degToRad(0);
    double anguloFinal = degToRad(360);

    if (numeroDeObjetivos == 0) {
      oval = Rect.fromCenter(
          center: c, width: (radius / 0.9), height: (radius / 0.9));

      Path p = Path();
      p.moveTo(width, height);
      p.addArc(oval, anguloInicio, anguloFinal);
      p.lineTo(width, height); //MoveTo ou LineTo
      p.close();

      Paint paint = Paint()
        ..color = Colors.white
        //..color = Colors.blueGrey
        ..style = PaintingStyle.fill;

      Paint paintC = Paint()
        ..color = Colors.black
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      final styleText = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
      );

      // if(controlador_clicado.clicado == mandalaController.idProjeto.value) {
      //   canvas.drawShadow(p, Colors.white, 15, true);
      // }
      canvas.drawPath(p, paint, onTapDown: (evento) {
        mandalaController.indiceObjective.value = -1;
        mandalaController.indiceResult.value = -1;
        controlador_clicado.mudaClicado(mandalaController.idProjeto.value);
      });
      if(controlador_clicado.clicado == mandalaController.idProjeto.value) {
        canvas.drawShadow(p, Colors.white, 15, true);
      }
      drawTextCentered(
          cv, c, mandalaController.nome.string, styleText3, radius * 0.5, 1);
      //drawTextArc(cv, Offset(size.width/2, size.height/2), 300, 0, "Projeto Mandala", styleText);

      // canvas.drawArc(oval, anguloInicio, anguloFinal, true, paint,
      //     onTapDown: (evento) {
      //   mandalaController.indice.value = -1;
      //   mandalaController.indiceResult.value = -1;
      // });
      //canvas.drawCircle(c, radius, paintC);
      //Desenhar os objetivos e não tem resultado ainda cadastrado
    } else if (numeroDeObjetivos >= 1) {
      var listaLines = [];
      var listaLinesResults = [];

      double anguloFinal = degToRad(360);

      if (numeroDeResultados == 0) {
        var anguloInicio = degToRad(0);
        var sweep;

        //Configurações do nível inicial (círculo com o nome do projeto)
        oval = Rect.fromCenter(
            center: c, width: (radius / 1.85), height: (radius / 1.85));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.white;

        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 0.9), height: (radius / 0.9));


        double prog;
        double diametro_Cinterno;
        double diametro_CMenor = oval.width;
        double diametro_CMaior = rectObjetivos.width;

        for (int o = 0; o < numeroDeObjetivos; o++) {
          anguloInicio = degToRad(listaObjetivos[o].startAngle);
          sweep = degToRad(listaObjetivos[o].sweepAngle);

          //Calcular progresso do objetivo
          prog = mandalaController.gerarProgresso(
              mandalaController.realizadoObjetivos(0.0,
                  mandalaController.listaObjectives[o].idObjetivo!),
              mandalaController.metaObjetivos(0.0,
                  mandalaController.listaObjectives[o].idObjetivo!))/100;

          diametro_Cinterno =
              diametro_CMenor + (diametro_CMaior - diametro_CMenor) * prog;

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectObjetivos, anguloInicio, sweep);
          path.lineTo(width, height);
          path.close();

          //Coloquei o radius do rectObjetivos
          final dx = radius / 1.8 * cos(anguloInicio);
          final dy = radius / 1.8 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          Paint? paint2 = mandalaController.criaPaintObjective(
              converteCor: listaObjetivos[o].paint, c:c, diametro_Cinterno: diametro_Cinterno);

          Path pedacoObjetivo = Path.combine(
              PathOperation.difference, path, p);
          //listPathObjetivos.add(path);
          listPathObjetivos.add(pedacoObjetivo);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);
        }

        for (int o = 0; o < numeroDeObjetivos; o++) {

          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
                if (mandalaController.editor.value == true ||
                    mandalaController.listaObjectives[o].donos!
                        .contains(auth.email.value)) {
                  mandalaController.ultimoNivelClicado.value = 2;
                  mandalaController.ultimoObjetivoClicado.value =
                      mandalaController.listaObjectives[o].idObjetivo
                          .toString();
                  mandalaController.nomeObjMandala.value =
                      mandalaController.listaObjectives[o].nome.toString();
                  mandalaController.progressoObj.value =
                      // mandalaController.listaObjectives[o].progresso!
                      //     .toDouble();
                  mandalaController.gerarProgresso(
                      mandalaController.realizadoObjetivos(0.0,
                          mandalaController.listaObjectives[o].idObjetivo!),
                      mandalaController.metaObjetivos(0.0,
                          mandalaController.listaObjectives[o].idObjetivo!));

                  mandalaController.data.value =
                  mandalaController.listaObjectives[o].dataVencimento!;
                  mandalaController.listaObjectives[o].dataVencimento!;
                  mandalaController.indiceObjective.value = o;

                  controller.mudaClicado(
                      mandalaController.listaObjectives[o].idObjetivo
                          .toString());
                }});
          if(controller.clicado == mandalaController.listaObjectives[o].idObjetivo.toString()){
            canvas.drawShadow(listPathObjetivos[o], Colors.grey.shade300, 14, true);
          }
          drawLabels(
              cv,
              c,
              radius,
              degToRad(listaObjetivos[o].startAngle),
              degToRad(listaObjetivos[o].sweepAngle),
              listaObjetivos[o].nome!,
              styleTextObjectiveWithoutResult,
              2);
        }

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint, onTapDown: (evento) {
          mandalaController.ultimoNivelClicado.value = 1;
          controller.mudaClicado(mandalaController.idProjeto.value);
        });
        // canvas.drawArc(
        //     oval, degToRad(0), degToRad(360), true, linePaint);

        if(controller.clicado == mandalaController.idProjeto.value) {
          canvas.drawShadow(p, Colors.grey.shade300, 5, true);
        }

        drawTextCentered(
            cv, c, mandalaController.nome.string, styleText2, radius * 0.5, 1);
      }

      else if (numeroDeResultados > 0) {
        anguloInicio = degToRad(0);
        anguloFinal = degToRad(360);

        oval = Rect.fromCenter(
            center: c, width: (radius / 2.5), height: (radius / 2.5));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.white;

        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 1.25), height: (radius / 1.25));

        rectResultados = Rect.fromCenter(
            center: c, width: (radius / 0.9), height: (radius / 0.9));

        double prog;
        double diametro_Cinterno;
        double diametro_CMenorObjetivo = oval.width;
        double diametro_CMaiorObjetivo = rectObjetivos.width;

        double diametro_CMenorResultado = rectObjetivos.width;
        double diametro_CMaiorResultado = rectResultados.width;

        var sweepObjetivo;

        for (int o = 0; o < numeroDeObjetivos; o++) {
          anguloInicio = degToRad(listaObjetivos[o].startAngle);
          sweepObjetivo = degToRad(listaObjetivos[o].sweepAngle);

          prog = mandalaController.gerarProgresso(
              mandalaController.realizadoObjetivos(0.0,
                  mandalaController.listaObjectives[o].idObjetivo!),
              mandalaController.metaObjetivos(0.0,
                  mandalaController.listaObjectives[o].idObjetivo!))/100;

          diametro_Cinterno =
              diametro_CMenorObjetivo + (diametro_CMaiorObjetivo - diametro_CMenorObjetivo) * prog;

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectObjetivos, anguloInicio, sweepObjetivo);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 2.5 * cos(anguloInicio);
          final dy = radius / 2.5 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          Paint? paint2 = mandalaController.criaPaintObjective(
              converteCor: listaObjetivos[o].paint, c:c, diametro_Cinterno: diametro_Cinterno);

          Path pedacoObjetivo = Path.combine(
              PathOperation.difference, path, p);

          // Path pedacoInterseccao = Path.combine(PathOperation.intersect, path, p);
          //
          // Path pedacoUnido = Path.combine(PathOperation.union, pedacoInterseccao, pedacoObjetivo);
          //
          //

          //listPathObjetivos.add(path);
          listPathObjetivos.add(pedacoObjetivo);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);

        }

        var sweepResult; // = degToRad(360 / numeroDeResultados);

        var listaResultados = mandalaController.listaResultados;

        for (int r = 0; r < listaResultados.length; r++) {
          anguloInicio = degToRad(listaResultados[r].startAngle);
          sweepResult = degToRad(listaResultados[r].sweepAngle);

          Path pathExtra = Path();
          pathExtra.moveTo(width, height);
          pathExtra.addArc(rectObjetivos, degToRad(0), degToRad(360));
          pathExtra.lineTo(width, height);
          pathExtra.close();

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectResultados, anguloInicio, sweepResult);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 1.8 * cos(anguloInicio);
          final dy = radius / 1.8 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          //Calcula progresso de resultado
          prog = mandalaController.gerarProgresso(
              mandalaController.listaResultados[r].realizado!,
              mandalaController.listaResultados[r].meta!)/100;

          diametro_Cinterno =
              diametro_CMenorResultado + (diametro_CMaiorResultado - diametro_CMenorResultado) * prog;

          Paint? paint = mandalaController.criaPaintObjective(
              converteCor: listaResultados[r].paint, c: c, diametro_Cinterno: diametro_Cinterno);

          Path pathResultado = Path.combine(PathOperation.difference, path, pathExtra);
          // listPathResultados.add(path);
          listPathResultados.add(pathResultado);
          listaLinesResults.add(p2);
          listPaintResultados.add(paint);
        }

        for (int r = 0; r < numeroDeResultados; r++) {

          canvas.drawPath(listPathResultados[r], listPaintResultados[r],
              onTapDown: (tapDownDetails) {
                if (mandalaController.editor.value == true ||
                    mandalaController.listaResultados[r].donoResultado!
                        .contains(auth.email.value)) {
                  mandalaController.ultimoNivelClicado.value = 3;
                  mandalaController.ultimoResultadoClicado.value =
                      mandalaController
                          .listaResultados
                          .elementAt(r)
                          .idResultado
                          .toString();
                  mandalaController.nomeResultMandala.value =
                      mandalaController.listaResultados[r].nomeResultado
                          .toString();
                  mandalaController.indiceResult.value = r;

                  mandalaController.progressoAtualResult.value =
                      mandalaController.gerarProgresso(
                          mandalaController.realizadoResulMetric(
                              mandalaController.periodo.value,
                              mandalaController.listaResultados[r].idResultado),
                          mandalaController.metasResulMetric(
                              mandalaController.periodo.value,
                              mandalaController.listaResultados[r]
                                  .idResultado));
                  mandalaController.progressoResult.value =
                      mandalaController.gerarProgresso(
                          mandalaController.listaResultados[r].realizado!,
                          mandalaController.listaResultados[r].meta!);
                  mandalaController.indiceResult.value = r;

                  controller.mudaClicado(
                      mandalaController.listaResultados[r].idResultado
                          .toString());
                  mandalaController.esvaziarFiltragem();
                  mandalaController.filtrarMetricas();
                }
            }, paintStyleForTouch: PaintingStyle.stroke);

          if(controller.clicado == mandalaController.listaResultados[r].idResultado.toString()){
            canvas.drawShadow(listPathResultados[r], Colors.grey.shade300, 10, true);
          }

          double? fontS = listaResultados.length < 8 ? 30 : 30;
          final styleTextResult = TextStyle(
            color: PaletaCores.black,
            fontWeight: FontWeight.normal,
            fontSize: fontS,
          );

          drawLabels(
              cv,
              c,
              radius,
              degToRad(listaResultados[r].startAngle),
              degToRad(listaResultados[r].sweepAngle),
              listaResultados[r].nomeResultado!,
              styleTextResult,
              3,
              nivel: 3);

        }
        listaLinesResults.forEach((element) {
          // final dxInit = radius / 2.5 * cos(anguloInicio);
          // final dyInit = radius / 2.5 * sin(anguloInicio);
          // canvas.drawLine(Offset(dxInit, dyInit), element, linePaint);


          canvas.drawLine(c, element, linePaint);
        });

        canvas.drawArc(
            rectObjetivos, degToRad(0), degToRad(360), true, linePaint);

        for (int o = 0; o < numeroDeObjetivos; o++) {


          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
                if (mandalaController.editor.value == true ||
                    mandalaController.listaObjectives[o].donos!
                        .contains(auth.email.value)) {
                  mandalaController.ultimoNivelClicado.value = 2;
                  mandalaController.ultimoObjetivoClicado.value =
                      mandalaController.listaObjectives[o].idObjetivo
                          .toString();
                  mandalaController.nomeObjMandala.value =
                      mandalaController.listaObjectives[o].nome.toString();
                  mandalaController.progressoObj.value =
                      mandalaController.gerarProgresso(
                          mandalaController.realizadoObjetivos(
                              0.0,
                              mandalaController.listaObjectives[o].idObjetivo!),
                          mandalaController.metaObjetivos(
                              0.0, mandalaController.listaObjectives[o]
                              .idObjetivo!));
                  mandalaController.progressoAtualObj.value =
                      mandalaController.gerarProgresso(
                          mandalaController.realizadoObjetivos(
                              mandalaController.periodo.value,
                              mandalaController.listaObjectives[o].idObjetivo!),
                          mandalaController.metaObjetivos(
                              mandalaController.periodo.value,
                              mandalaController.listaObjectives[o]
                                  .idObjetivo!));
                  mandalaController.data.value =
                  mandalaController.listaObjectives[o].dataVencimento!;
                  mandalaController.indiceObjective.value = o;
                  controller.mudaClicado(
                      mandalaController.listaObjectives[o].idObjetivo
                          .toString());

                }
          });
          if(controller.clicado == mandalaController.listaObjectives[o].idObjetivo.toString()){
            canvas.drawShadow(listPathObjetivos[o], Colors.grey.shade300, 10, true);
          }
          drawLabels(
              cv,
              c,
              radius,
              degToRad(listaObjetivos[o].startAngle),
              degToRad(listaObjetivos[o].sweepAngle),
              listaObjetivos[o].nome!,
              styleTextObjectiveWithResult,
              3,
              nivel: 2);
        }

        canvas.drawArc(
            rectObjetivos, degToRad(0), degToRad(360), true, linePaint);

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint, onTapDown: (evento) {
          mandalaController.ultimoNivelClicado.value = 1;
          controller.mudaClicado(mandalaController.idProjeto.value);
        });

        //canvas.drawShadow(p, Colors.black87, 10, true);
        if(controller.clicado == mandalaController.idProjeto.value){
          canvas.drawShadow(p, Colors.grey.shade300, 10, true);
        }

        drawTextCentered(
            cv, c, mandalaController.nome.string, styleText2, radius * 0.5, 1);
      }
    } else {

    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);

    drawObject(myCanvas, canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //return oldDelegate != this;
    return true;
  }

  TextPainter measureText(String text, TextStyle style, double maxWidth,
      TextAlign align, int quantNivel) {
    if (quantNivel == 1) {
      final textSpan = TextSpan(text: text, style: style);
      final tp = TextPainter(
          textScaleFactor: 0.85,
          maxLines: 4,
          text: textSpan,
          textAlign: align,
          textDirection: TextDirection.ltr);
      tp.layout(minWidth: 0, maxWidth: maxWidth);
      return tp;
    } else if (quantNivel == 2) {
      final textSpan = TextSpan(text: text, style: style);
      final tp = TextPainter(
          textScaleFactor: 0.55,
          maxLines: 4,
          text: textSpan,
          textAlign: align,
          textDirection: TextDirection.ltr);
      tp.layout(minWidth: 0, maxWidth: maxWidth);
      return tp;
    } else if (quantNivel == 3) {
      final textSpan = TextSpan(text: text, style: style);
      final tp = TextPainter(
          textScaleFactor: 0.35,
          maxLines: 4,
          text: textSpan,
          textAlign: align,
          textDirection: TextDirection.ltr);
      tp.layout(minWidth: 0, maxWidth: maxWidth);
      return tp;
    } else {
      final textSpan = TextSpan(text: text, style: style);
      final tp = TextPainter(
          textScaleFactor: 0.1,
          maxLines: 4,
          text: textSpan,
          textAlign: align,
          textDirection: TextDirection.ltr);
      tp.layout(minWidth: 0, maxWidth: maxWidth);
      return tp;
    }
  }

  void drawLabels(Canvas canvas, Offset c, double radius, startAngle,
      sweepAngle, String text, TextStyle styleText2, int quantNivel,
      {int nivel = 0}) {
    if (quantNivel == 1) {
      final r = radius * 0.35;
      final dx = r * cos(startAngle + sweepAngle / 2.0);
      final dy = r * sin(startAngle + sweepAngle / 2.0);
      final position = c + Offset(dx, dy);
      drawTextCentered(canvas, position, text, styleText2, 160.0, quantNivel);
    } else if (quantNivel == 2) {
      final r = radius * 0.40;
      final dx = r * cos(startAngle + sweepAngle / 2.0);
      final dy = r * sin(startAngle + sweepAngle / 2.0);
      final position = c + Offset(dx, dy);
      drawTextCentered(canvas, position, text, styleText2, 160.0, quantNivel);
    } else if (quantNivel == 3) {
      if (nivel == 2) {
        final r = radius * 0.30;
        final dx = r * cos(startAngle + sweepAngle / 2.0);
        final dy = r * sin(startAngle + sweepAngle / 2.0);
        final position = c + Offset(dx, dy);
        drawTextCentered(canvas, position, text, styleText2, 120.0, quantNivel);
      }
      if (nivel == 3) {
        final r = radius * 0.46;
        final dx = r * cos(startAngle + sweepAngle / 2.0);
        final dy = r * sin(startAngle + sweepAngle / 2.0);
        final position = c + Offset(dx, dy);
        drawTextCentered(canvas, position, text, styleText2, 80.0, quantNivel);
      }
    }
  }

  Size drawTextCentered(Canvas canvas, Offset position, String text,
      TextStyle style, double maxWidth, int quantNivel) {
    final tp = measureText(text, style, maxWidth, TextAlign.center, quantNivel);
    final pos = position + Offset(-tp.width / 2.0, -tp.height / 2.0);
    tp.paint(canvas, pos);
    return tp.size;
  }

  TextPainter measureText2(Canvas canvas, String text, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    return textPainter;
  }

  void drawTextArc(Canvas canvas, Offset arcCenter, double radius, double a,
      String text, style) {
    final pos = Offset(0, radius);
    text.split('').forEach((c) {
      final tp = measureText2(canvas, c, style);
      final w = tp.width + 1.0;
      final double alpha = asin(w / (2 * radius));
      //canvas.save();
      canvas.translate(arcCenter.dx, arcCenter.dy);
      a += alpha;
      tp.paint(canvas, pos + Offset(-w / 2.0, 0.0));
      canvas.restore();
    });
  }
}
