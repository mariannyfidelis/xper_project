import 'dart:math';
import 'package:get/get.dart';
import '/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:touchable/touchable.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ArcoAutomatico extends CustomPainter {
  BuildContext context;
  ProjectModel? modeloProjeto;

  ArcoAutomatico(this.context);

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  void drawObject2(TouchyCanvas canvas, Size size) {
    //Configuração do desenho
    double width = size.width / 2;
    double height = size.height / 2;
    final c = Offset(width, height);
    final radius = size.width * 0.8;

    final linePaint = Paint() //Cor da linha
      ..color = Colors.white //Color.fromRGBO(56, 56, 56, 1) //white
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    //ProjectModel? projetoAtual = mandalaController.getProjectModel();

    var mandalaController = Get.find<ControllerProjetoRepository>();
    int niveis = mandalaController.niveis;
    int nv = mandalaController.nv;
    int numeroDeObjetivos = mandalaController.listaObjectives.length;
    int numeroDeResultados = mandalaController.listaResultados.length;
    int numeroDeMetricas = mandalaController.listaMetricas.length;

    //Serão três retângulos para desenhar
    Rect oval;
    Rect rectObjetivos;
    Rect rectResultados;
    Rect rectMetricas;

    List<Path> listPathObjetivos = [];
    List<Path> listPathResultados = [];
    List<Paint> listPaintObjetivos = [];
    List<Paint> listPaintResultados = [];

    double anguloInicio = degToRad(0);
    double anguloFinal = degToRad(360);

    //Não tem objetivo ainda cadastrado
    if (numeroDeObjetivos == 0) {
      oval =
          Rect.fromCenter(center: c, width: (radius / 1), height: (radius / 1));

      Path p = Path();
      p.moveTo(width, height);
      p.addArc(oval, anguloInicio, anguloFinal);
      p.lineTo(width, height); //MoveTo ou LineTo
      p.close();

      Paint paint = Paint()
        ..color = Colors.blueGrey
        ..style = PaintingStyle.fill;

      Paint paintC = Paint()
        ..color = Colors.black
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;

      //descomentar aqui !!!!!!!!!
      // canvas.drawPath(p, paint, onTapDown: (tapDownDetails) {
      //   mandalaController.ultimoNivelClicado = 1;
      //   print("xx Ultimo nivel clicado - $ultimoNivelClicado");
      // });

      canvas.drawArc(oval, anguloInicio, anguloFinal, true, paint,
          onTapDown: (evento) {
        mandalaController.indice.value = -1;
        mandalaController.indiceResult.value = -1;
      });
      //canvas.drawCircle(c, radius, paintC);

      //Desenhar os objetivos e não tem resultado ainda cadastrado
    } else if (numeroDeObjetivos >= 1) {
      var listaLines = [];
      var listaLinesResults = [];

      double anguloInicio = degToRad(0);
      double anguloFinal = degToRad(360);

      if (numeroDeResultados == 0) {
        //Configurações do nível inicial (círculo com o nome do projeto)
        oval = Rect.fromCenter(
            center: c, width: (radius / 2), height: (radius / 2));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.blueGrey;

        //Configurações do nível Objetivo (círculo com a lista de objetivos)
        print("\nTenho $numeroDeObjetivos de objetivos para desenhar");

        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 1), height: (radius / 1));

        double sweep = degToRad(360 / numeroDeObjetivos);

        anguloInicio = degToRad(0);
        //double anguloFinal = degToRad(360);

        for (int o = 0; o < numeroDeObjetivos; o++) {
          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectObjetivos, anguloInicio, sweep /*anguloFinal*/);
          path.lineTo(width, height);
          path.close();

          //Coloquei o radius do rectObjetivos
          final dx = radius / 2.0 * cos(anguloInicio);
          final dy = radius / 2.0 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);
          anguloInicio = anguloInicio + sweep;

          Paint? paint2 = mandalaController.criaPaintObjective();

          /*  Adicionar nas listas */
          listPathObjetivos.add(path);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);
        }

        //Desenhar os dois níveis
        //Uma repetição para desenhar
        for (int o = 0; o < numeroDeObjetivos; o++) {
          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 2;
            mandalaController.ultimoObjetivoClicado.value =
                mandalaController.listaObjectives[o].idObjetivo.toString();
            mandalaController.nomeObjMandala.value =
                mandalaController.listaObjectives[o].nome.toString();
            mandalaController.progressoObj.value =
                mandalaController.listaObjectives[o].progresso!.toDouble();
            mandalaController.data.value =
                mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.indice.value = o;

            print(
                "xx pedaço clicado - ${mandalaController.ultimoObjetivoClicado.value}");
            print("xx Ultimo nivel clicado - 2");
          });
        }

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint);
      } else if (numeroDeResultados > 0) {
        double anguloInicio = degToRad(0);
        double anguloFinal = degToRad(360);

        print("\nTenho $numeroDeResultados de resultados para desenhar");

        //Nível interno
        oval = Rect.fromCenter(
            center: c, width: (radius / 2.5), height: (radius / 2.5));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.blueGrey;

        //Objetivos desenho !!!
        print("\nTenho $numeroDeObjetivos de objetivos para desenhar");
        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 1.5), height: (radius / 1.5));

        rectResultados = Rect.fromCenter(
            center: c, width: (radius / 1), height: (radius / 1));

        anguloInicio = degToRad(0);
        var sweepResult = degToRad(360 / numeroDeResultados);

        for (int r = 0; r < numeroDeResultados; r++) {
          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectResultados, anguloInicio, sweepResult);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 2.0 * cos(anguloInicio);
          final dy = radius / 2.0 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          anguloInicio = anguloInicio + sweepResult;

          Paint? paint = mandalaController.criaPaintObjective();

          /*  Adicionar nas listas */
          listPathResultados.add(path);
          listaLinesResults.add(p2);
          listPaintResultados.add(paint);
        }

        anguloInicio = degToRad(0);
        var sweepObjetivo = degToRad(360 / numeroDeObjetivos);

        for (int o = 0; o < numeroDeObjetivos; o++) {
          Path path = Path();
          path.moveTo(width, height);
          path.addArc(
              rectObjetivos, anguloInicio, sweepObjetivo /*anguloFinal*/);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 1.5 * cos(anguloInicio);
          final dy = radius / 1.5 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);
          anguloInicio = anguloInicio + sweepObjetivo;

          Paint? paint2 = mandalaController.criaPaintObjective();

          /*  Adicionar nas listas */
          listPathObjetivos.add(path);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);
        }

        //Desenhar primeiro Resultados
        for (int r = 0; r < numeroDeResultados; r++) {
          debugPrint("Entrei no resultado ${r + 1}");
          canvas.drawPath(listPathResultados[r], listPaintResultados[r],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 3;
            mandalaController.ultimoResultadoClicado.value = mandalaController
                .listaResultados
                .elementAt(r)
                .idResultado
                .toString();
            mandalaController.nomeResultMandala.value =
                mandalaController.listaResultados[r].nomeResultado.toString();
            mandalaController.progressoResult.value =
                mandalaController.listaResultados[r].progresso!.toDouble();
            mandalaController.indiceResult.value = r;

            print(
                "xx pedaço clicado - ${mandalaController.ultimoResultadoClicado}");
            print("xx Ultimo nivel clicado - 3");
          }, paintStyleForTouch: PaintingStyle.stroke);
        }
        listaLinesResults.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenhar em seguida Objetivos
        for (int o = 0; o < numeroDeObjetivos; o++) {
          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 2;
            mandalaController.ultimoObjetivoClicado.value =
                mandalaController.listaObjectives[o].idObjetivo.toString();
            mandalaController.nomeObjMandala.value =
                mandalaController.listaObjectives[o].nome.toString();
            mandalaController.progressoObj.value =
                mandalaController.listaObjectives[o].progresso!.toDouble();
            mandalaController.data.value =
                mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.indice.value = o;

            print(
                "xx pedaço clicado - ${mandalaController.ultimoObjetivoClicado.value}");
            //     mandalaController.ultimoNivelClicado = o;
            // print(
            //     "xx pedaço clicado - ${mandalaController.ultimoNivelClicado}");
            print("xx Ultimo nivel clicado - 2");
          });
        }

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint, onSecondaryTapDown: (evento) {
          print(evento);
          print("cliquei secondary");
        }, onTapDown: (evento) {
          print(evento);
          print("cliquei tap down");
        }, onPanDown: (tapdetail) {
          print("orange circle swiped");
        });
      }
    } else {
      // Nenhum objetivo ou nulo
      print("Tenho $numeroDeObjetivos de objetivos para desenhar");
    }
  }

  void drawObject(TouchyCanvas canvas, Size size) {
    double width = size.width / 2;
    double height = size.height / 2;
    final c = Offset(width, height);
    final radius = size.width * 0.8;

    final linePaint = Paint() //Cor da linha
      ..color = Colors.white
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

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

    //Não tem objetivo ainda cadastrado
    if (numeroDeObjetivos == 0) {
      oval =
          Rect.fromCenter(center: c, width: (radius / 1), height: (radius / 1));

      Path p = Path();
      p.moveTo(width, height);
      p.addArc(oval, anguloInicio, anguloFinal);
      p.lineTo(width, height); //MoveTo ou LineTo
      p.close();

      Paint paint = Paint()
        ..color = Colors.blueGrey
        ..style = PaintingStyle.fill;

      Paint paintC = Paint()
        ..color = Colors.black
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke;

      canvas.drawPath(p, paint, onTapDown: (evento) {
        mandalaController.indice.value = -1;
        mandalaController.indiceResult.value = -1;
      });

      canvas.drawShadow(p, Colors.white, 5, true);
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
            center: c, width: (radius / 2), height: (radius / 2));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.blueGrey;

        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 1), height: (radius / 1));

        for (int o = 0; o < numeroDeObjetivos; o++) {
          anguloInicio = degToRad(listaObjetivos[o].startAngle);
          sweep = degToRad(listaObjetivos[o].sweepAngle);

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectObjetivos, anguloInicio, sweep);
          path.lineTo(width, height);
          path.close();

          //Coloquei o radius do rectObjetivos
          final dx = radius / 2.0 * cos(anguloInicio);
          final dy = radius / 2.0 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          Paint? paint2 = mandalaController.criaPaintObjective(
              converteCor: listaObjetivos[o].paint);

          listPathObjetivos.add(path);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);
        }

        for (int o = 0; o < numeroDeObjetivos; o++) {
          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 2;
            mandalaController.ultimoObjetivoClicado.value =
                mandalaController.listaObjectives[o].idObjetivo.toString();
            mandalaController.nomeObjMandala.value =
                mandalaController.listaObjectives[o].nome.toString();
            mandalaController.progressoObj.value =
                mandalaController.listaObjectives[o].progresso!.toDouble();
            mandalaController.data.value =
                mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.indice.value = o;
            print(
                "xx pedaço clicado - ${mandalaController.ultimoObjetivoClicado.value}");
            print("xx Ultimo nivel clicado - 2");
          });
        }

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint);
      } else if (numeroDeResultados > 0) {
        anguloInicio = degToRad(0);
        anguloFinal = degToRad(360);

        oval = Rect.fromCenter(
            center: c, width: (radius / 2.5), height: (radius / 2.5));

        Path p = Path();
        p.moveTo(width, height);
        p.addArc(oval, anguloInicio, anguloFinal);
        p.lineTo(width, height);
        p.close();

        Paint paint = Paint()..color = Colors.blueGrey;

        rectObjetivos = Rect.fromCenter(
            center: c, width: (radius / 1.25), height: (radius / 1.25));

        rectResultados = Rect.fromCenter(
            center: c, width: (radius / 0.9), height: (radius / 0.9));

        var sweepResult; // = degToRad(360 / numeroDeResultados);

        var listaResultados = mandalaController.listaResultados;

        for (int r = 0; r < listaResultados.length; r++) {
          anguloInicio = degToRad(listaResultados[r].startAngle);
          sweepResult = degToRad(listaResultados[r].sweepAngle);

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectResultados, anguloInicio, sweepResult);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 1.8 * cos(anguloInicio);
          final dy = radius / 1.8 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          Paint? paint = mandalaController.criaPaintObjective(converteCor: listaResultados[r].paint);

          listPathResultados.add(path);
          listaLinesResults.add(p2);
          listPaintResultados.add(paint);
        }

        var sweepObjetivo;

        for (int o = 0; o < numeroDeObjetivos; o++) {
          anguloInicio = degToRad(listaObjetivos[o].startAngle);
          sweepObjetivo = degToRad(listaObjetivos[o].sweepAngle);

          Path path = Path();
          path.moveTo(width, height);
          path.addArc(rectObjetivos, anguloInicio, sweepObjetivo);
          path.lineTo(width, height);
          path.close();

          final dx = radius / 2.5 * cos(anguloInicio);
          final dy = radius / 2.5 * sin(anguloInicio);
          final p2 = c + Offset(dx, dy);

          Paint? paint2 = mandalaController.criaPaintObjective(converteCor: listaObjetivos[o].paint);

          listPathObjetivos.add(path);
          listaLines.add(p2);
          listPaintObjetivos.add(paint2);
        }

        for (int r = 0; r < numeroDeResultados; r++) {
          canvas.drawPath(listPathResultados[r], listPaintResultados[r],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 3;
            mandalaController.ultimoResultadoClicado.value = mandalaController
                .listaResultados
                .elementAt(r)
                .idResultado
                .toString();
            mandalaController.nomeResultMandala.value =
                mandalaController.listaResultados[r].nomeResultado.toString();
            mandalaController.progressoResult.value =
                mandalaController.listaResultados[r].progresso!.toDouble();
            mandalaController.indiceResult.value = r;

            print(
                "xx pedaço clicado - ${mandalaController.ultimoResultadoClicado}");
            print("xx Ultimo nivel clicado - 3");
          }, paintStyleForTouch: PaintingStyle.stroke);
        }
        listaLinesResults.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });
        canvas.drawArc(rectObjetivos, degToRad(0), degToRad(360), true, linePaint);
        for (int o = 0; o < numeroDeObjetivos; o++) {
          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
            mandalaController.ultimoNivelClicado.value = 2;
            mandalaController.ultimoObjetivoClicado.value =
                mandalaController.listaObjectives[o].idObjetivo.toString();
            mandalaController.nomeObjMandala.value =
                mandalaController.listaObjectives[o].nome.toString();
            mandalaController.progressoObj.value =
                mandalaController.listaObjectives[o].progresso!.toDouble();
            mandalaController.data.value =
                mandalaController.listaObjectives[o].dataVencimento!;
            mandalaController.indice.value = o;

            print(
                "xx pedaço clicado - ${mandalaController.ultimoObjetivoClicado.value}");
            print("xx Ultimo nivel clicado - 2");
          });
        }

        listaLines.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenha o nível mais interno
        canvas.drawPath(p, paint, onSecondaryTapDown: (evento) {
          print(evento);
          print("cliquei secondary");
        }, onTapDown: (evento) {
          print(evento);
          print("cliquei tap down");
        }, onPanDown: (tapdetail) {
          print("orange circle swiped");
        });
      }
    } else {
      // Nenhum objetivo ou nulo
      print("Tenho $numeroDeObjetivos de objetivos para desenhar");
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    drawObject(myCanvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
