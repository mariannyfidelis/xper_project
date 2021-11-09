import 'dart:math';
import 'package:get/get.dart';
import '/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class ArcoAutomatico extends CustomPainter {
  BuildContext context;
  ProjectModel? modeloProjeto;

  ArcoAutomatico(this.context);

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  void drawObjetivos3(TouchyCanvas canvas, Size size) {
    var orangeCircleCenter = Offset(size.width / 2, size.height / 2 + 100);
    canvas.drawCircle(
        orangeCircleCenter, 80, Paint()..color = Colors.orangeAccent,
        onTapDown: (_) {
      print("cliquei orange");
    });
    canvas.drawCircle(
      orangeCircleCenter,
      50,
      Paint()..color = Colors.green,
      onTapDown: (_) {
        print("cliquei green");
      }, /*hitTestBehavior: HitTestBehavior.translucent*/
    );
    canvas.drawCircle(
      orangeCircleCenter,
      30,
      Paint()..color = Colors.blue,
      onTapDown: (_) {
        print("cliquei no blue");
      }, /*hitTestBehavior: HitTestBehavior.translucent*/
    );
    canvas
        .drawCircle(orangeCircleCenter, 20, Paint()..color = Colors.deepPurple,
            onTapDown: (_) {
      print("cliquei purple");
    }, hitTestBehavior: HitTestBehavior.opaque);
  }

  void desenhaPrimeiroObjetivoPrimario(
      TouchyCanvas canvas, Offset c, double radius, Size size, int dist) {
    /*List<ObjetivoModel> objetivos = controller.objs;

    final oval = Rect.fromCenter(
      center: c,
      width: (radius / niveis) * (niveis - nv) - dist,
      height: (radius / niveis) * (niveis - nv) - dist,
    ); //Cada nível tem um retângulo (oval)

    Path path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.addArc(oval, degToRad(0), degToRad(360));
    path.lineTo(size.width / 2, size.height / 2);
    path.close();

    var paint = Paint()..color = Colors.white24;

    ObjetivoModel objetivoModel = new ObjetivoModel(
        name: "Objetivo $niveis",
        nivel: niveis,
        nivelPai: nv,
        idObjetivo: niveis,
        idObjetivoPai: nv);
    controller.changeSize(size);
    objetivoModel.setPath(path);
    objetivoModel.setPaint(paint);
    objetivoModel.setOval(oval);
    objetivos.add(objetivoModel);

    canvas.drawPath(path, paint, onTapDown: (_) {
      print("cliquei no white ...");
    });
    */
  }

  void drawObjetivos2(TouchyCanvas canvas, Size size) {
    /*controller.changeSize(size);
    final c = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.8;
    List<ObjetivoModel> objetivos = controller.objs;

    if (objetivos.isEmpty) {
      desenhaPrimeiroObjetivoPrimario(canvas, c, radius, size, 0);
      var cnivel = controller.niveis;
      controller.niveis++;
      controller.nv = cnivel;
      controller.ultimoNivelClicado = cnivel;
      print("desenhei o primeiro");
    } else {
      print("tamanho da lista - ${objetivos.length}");
      if (size != controller.size) {
        print('tela de tamanho diferente');
        controller.changeSize(size);
      } else {
        List<Path> paths = [];
        List<Paint> paints = [];
        List<Rect> ovals = [];
        for (var objetivo in objetivos) {
          print("${objetivo.name} - ${objetivo.nivel} - ${objetivo.nivelPai}");

          final oval = Rect.fromCenter(
            center: c,
            width: (radius / niveis) * (niveis - nv),
            height: (radius / niveis) * (niveis - nv),
          );
          Path p = Path();
          p.moveTo(size.width / 2, size.height / 2);
          p.addArc(oval, degToRad(objetivo.startAngle),
              degToRad(objetivo.sweepAngle));
          p.lineTo(size.width / 2, size.height / 2);
          p.close();

          Paint? paint = objetivo.paint;
          paths.add(p);
          paints.add(paint!);
          ovals.add(oval);
        }

        for (var objetivo in objetivos) {
          Path? p = objetivo.path;
          Paint? pt = objetivo.paint;
          canvas.drawPath(p!, pt!, onTapDown: (details) {
            print("Nivel clicado - ${objetivo.nivel}");
          });
        }
      }
    }
*/
    // //Cada nível tem um retângulo (oval)
    // final oval = Rect.fromCenter(
    //   center: c,
    //   width: (radius / niveis) * (niveis - nv),
    //   height: (radius / niveis) * (niveis - nv),
    // );

    // final oval2 = Rect.fromCenter(
    //   center: c,
    //   width: (radius / niveis) * (niveis - nv) - 100,
    //   height: (radius / niveis) * (niveis - nv) - 100,
    // );

    // final oval3 = Rect.fromCenter(
    //   center: c,
    //   width: (radius / niveis) * (niveis - nv) - 200,
    //   height: (radius / niveis) * (niveis - nv) - 200,
    // );

    // Path p6 = Path();
    // p6.moveTo(size.width / 2, size.height / 2);
    // p6.addArc(oval2, degToRad(0), degToRad(360));
    // p6.lineTo(size.width / 2, size.height / 2);
    // p6.close();

    // Path p7 = Path();
    // p7.moveTo(size.width / 2, size.height / 2);
    // p7.addArc(oval3, degToRad(0), degToRad(360));
    // p7.lineTo(size.width / 2, size.height / 2);
    // p7.close();

    // Path p = Path();
    // p.moveTo(size.width / 2, size.height / 2);
    // p.addArc(oval, 0, (pi / 2) / 2);
    // p.lineTo(size.width / 2, size.height / 2);
    // p.close();

    // Path p2 = Path();
    // p2.moveTo(size.width / 2, size.height / 2);
    // p2.addArc(oval, degToRad(45), degToRad(45));
    // p2.lineTo(size.width / 2, size.height / 2);
    // p2.close();

    // Path p3 = Path();
    // p3.moveTo(size.width / 2, size.height / 2);
    // p3.addArc(oval, degToRad(90), degToRad(90));
    // p3.lineTo(size.width / 2, size.height / 2);
    // p3.close();

    // Path p4 = Path();
    // p4.moveTo(size.width / 2, size.height / 2);
    // p4.addArc(oval, degToRad(180), degToRad(90));
    // p4.lineTo(size.width / 2, size.height / 2);
    // p4.close();

    // Path p5 = Path();
    // p5.moveTo(size.width / 2, size.height / 2);
    // p5.addArc(oval, degToRad(270), degToRad(90));
    // p5.lineTo(size.width / 2, size.height / 2);
    // p5.close();

    // //canvas.drawPath(p, Paint()..color = Colors.orangeAccent);
    // canvas.drawPath(p, Paint()..color = Colors.blueAccent, onTapDown: (_) {
    //   print("cliquei no blueAccent ...");
    // });
    // canvas.drawPath(p2, Paint()..color = Colors.pink, onTapDown: (_) {
    //   print("cliquei no pink ...");
    // });
    // canvas.drawPath(p3, Paint()..color = Colors.yellowAccent, onTapDown: (_) {
    //   print("cliquei no yellow ...");
    // });
    // canvas.drawPath(p4, Paint()..color = Colors.orangeAccent, onTapDown: (_) {
    //   print("cliquei no orange ...");
    // });
    // canvas.drawPath(p5, Paint()..color = Colors.greenAccent, onTapDown: (_) {
    //   print("cliquei no verde ...");
    // });
    // canvas.drawPath(p6, Paint()..color = Colors.white, onTapDown: (_) {
    //   print("cliquei no branco ...");
    // });
    // canvas.drawPath(p7, Paint()..color = Colors.black, onTapDown: (_) {
    //   print("cliquei no preto ...");
    // });
  }

  void drawObjetivos(TouchyCanvas canvas, Size size) {
    /*
    controller.changeSize(size);
    double width = size.width / 2;
    double height = size.height / 2;
    final c = Offset(width, height);
    final radius = size.width * 0.8;
    List<Rect> listOvals = [];
    List<Path> listPath = [];
    List<Paint> listPaint = [];
    List<int> crieiNivel = [];
    List<ObjetivoModel> objetivos = controller.objs;

    Rect oval;
    Path? pathUnion;

    if (objetivos.length == 1) {
      print("obj - um objetivo");
      print("obj - ${objetivos[0].name}");
      print("obj - ${objetivos[0].nivel}");
      print("obj - ${objetivos[0].nivelPai}");
      print("obj - ${objetivos[0].startAngle}");
      print("obj - ${objetivos[0].sweepAngle}");

      //Objetivo principal único
      oval = Rect.fromCenter(
          center: c,
          width: (radius / niveis) * (niveis - nv),
          height: (radius / niveis) * (niveis - nv));
      double anguloInicio = degToRad(objetivos[0].startAngle);
      double anguloFinal = degToRad(objetivos[0].sweepAngle);
      //print("obj - angulos de [$anguloInicio] a [$anguloFinal]");

      Path p = Path();
      p.moveTo(width, height);
      p.addArc(oval, anguloInicio, anguloFinal);
      p.lineTo(width, height);
      p.close();

      Paint? paint = objetivos[0].paint;
      listPath.add(p);
      listOvals.add(oval);
      listPaint.add(paint!);
      print(
          "obj - paths[${listPath.length}] - ovals [${listOvals.length}] - paints[${listPaint.length}]");
    } else if (objetivos.length > 1) {
      //Tem no mínimo dois objetivos
      for (int index = 0; index < controller.niveis; index++) {
        crieiNivel.add(-1);
        //Nenhum oval Rect criado; Só cria se for um novo nível
      }

      for (ObjetivoModel objetivo in objetivos) {
        print("obj - #######################################");
        print("obj - objetivo - xx - ${objetivo.idObjetivo}");
        print("obj - ${objetivos[objetivo.idObjetivo - 1].name}");
        print("obj - ${objetivos[objetivo.idObjetivo - 1].nivel}");
        print("obj - ${objetivos[objetivo.idObjetivo - 1].nivelPai}");
        print("obj - ${objetivos[objetivo.idObjetivo - 1].startAngle}");
        print("obj - ${objetivos[objetivo.idObjetivo - 1].sweepAngle}");

        if (crieiNivel[objetivo.nivel - 1] == -1) {
          oval = Rect.fromCenter(
            center: c,
            width: (radius / niveis) * objetivo.nivel,
            height: (radius / niveis) * objetivo.nivel,
          );
          //Atualiza o vetor de controle de nível criado
          crieiNivel[objetivo.nivel - 1] = 1;
          listOvals.add(oval);
        } else {
          //Já existe um oval para o nível e este é um objetivo secundário
          oval = listOvals.elementAt(objetivo.nivel - 1);
        }
        print("objs - numero de ovals - ${crieiNivel.length}");

        Paint? paint = objetivo.paint;
        listPaint.add(paint!);

        Path p2 = Path();
        p2.moveTo(width, height);
        p2.addArc(
            oval, degToRad(objetivo.startAngle), degToRad(objetivo.sweepAngle));
        p2.lineTo(width, height);
        p2.close();

        if (objetivo.nivel == 1) {
          //Testar se utilizando o p2 do Path criando antes funciona !
          listPath.add(p2);
        } else if (objetivo.nivel == 2) {
          Path pathFinal =
              Path.combine(PathOperation.difference, p2, listPath[0]);
          listPath.add(pathFinal);
          pathUnion = Path.combine(PathOperation.union, pathFinal, listPath[0]);
        } else if (objetivo.nivel > 2) {
          Path pathFinal =
              Path.combine(PathOperation.difference, p2, pathUnion!);
          pathUnion = Path.combine(PathOperation.union, pathFinal, pathUnion);
          listPath.add(pathFinal);
        } else {}
      } // Finalizando o for objetivos
    } else {} // Essa situação aqui é um erro !

    // for (ObjetivoModel objetivo in objetivos) {
    //   //Identificar unicamento um determinado objetivo
    //   int idObjetivo = objetivo.idObjetivo;
    //   canvas.drawPath(listPath[idObjetivo - 1], listPaint[idObjetivo - 1]);
    // }
    print("obj - #######################################");
    for (int novo = niveis - 1; novo >= 0; novo--) {
      print("obj - id do Objetivo - ${novo + 1}");
      canvas.drawPath(listPath[novo], listPaint[novo] /*lsPaint[nv]*/,
          onTapDown: (tapDownDetails) {
        controller.ultimoNivelClicado = novo;
        print("xx Ultimo nivel clicado - $ultimoNivelClicado");
      });
    }
    print("obj - #######################################");
*/
  }

  void drawObject(TouchyCanvas canvas, Size size) {
    //Configuração do desenho
    double width = size.width / 2;
    double height = size.height / 2;
    final c = Offset(width, height);
    final radius = size.width * 0.9;

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

    print("Numero de niveis: [$niveis] e nv - [$nv]");
    print("Numero de objetivos: $numeroDeObjetivos");
    print("Numero de resultados: $numeroDeResultados");
    print("Numero de metricas: $numeroDeMetricas");

    //Serão três retângulos para desenhar
    //Será uma região de desenho para cada uma
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
      //Desenhar a bola central
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

      canvas.drawArc(oval, anguloInicio, anguloFinal, true, paint, onTapDown: (evento){

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
            mandalaController.ultimoObjetivoClicado.value = mandalaController.listaObjectives[o].idObjetivo.toString();
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
      }
      else if (numeroDeResultados > 0) {

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
            mandalaController.ultimoResultadoClicado.value = mandalaController.listaResultados.elementAt(r).idResultado.toString();
            print(
                "xx pedaço clicado - ${mandalaController.ultimoResultadoClicado}");
            print("xx Ultimo nivel clicado - 3");
          });
        }
        listaLinesResults.forEach((element) {
          canvas.drawLine(c, element, linePaint);
        });

        //Desenhar em seguida Objetivos
        for (int o = 0; o < numeroDeObjetivos; o++) {
          canvas.drawPath(listPathObjetivos[o], listPaintObjetivos[o],
              onTapDown: (tapDownDetails) {
                mandalaController.ultimoObjetivoClicado.value = mandalaController.listaObjectives[o].idObjetivo.toString();
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
        canvas.drawPath(p, paint, onSecondaryTapDown: (evento){
          print(evento);
          print("cliquei secondary");
        },
        onTapDown: (evento){
          print(evento);
          print("cliquei tap down");
        },
            onPanDown:(tapdetail){
              print("orange circle swiped");
            }
        );
      }
    } else {
      // Nenhum objetivo ou nulo
      print("Tenho $numeroDeObjetivos de objetivos para desenhar");
    }
  }

  drawCirculoCentral() {}
  drawSectorsResultados(
      TouchyCanvas canvas,
      Rect rectResults,
      int numeroResultados,
      double width,
      double height,
      double radius,
      double anguloInicio,
      Offset c,
      List listPathResults,
      List listaLinesResults,
      List listPaintResults) {
    double sweep = degToRad(360 / numeroResultados);
    var mandalaController = Get.find<ControllerProjetoRepository>();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    //drawObjetivos(myCanvas, size);
    drawObject(myCanvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}