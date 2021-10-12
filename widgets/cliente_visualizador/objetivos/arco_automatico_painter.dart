import 'dart:math';
import '/models/objetivo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';
import '/controllers/dados_controller.dart';

class ArcoAutomatico extends CustomPainter {
  BuildContext context;
  ObjectiveController controller;

  ArcoAutomatico(this.context)
      : controller = Provider.of<ObjectiveController>(context, listen: false);

  double degToRad(double deg) => deg * (pi / 180.0);

  double radToDeg(double rad) => rad * (180.0 / pi);

  int get niveis {
    return controller.niveis;
  }

  int get nv {
    return controller.nv;
  }

  int get ultimoNivelClicado {
    return controller.ultimoNivelClicado;
  }

  Paint get paintObjective {
    return controller.criaPaintObjective();
  }

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

  desenhaPrimeiroObjetivoPrimario(
      TouchyCanvas canvas, Offset c, double radius, Size size, int dist) {
    List<ObjetivoModel> objetivos = controller.objs;

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
  }

  //Versão antiga do drawObjetivos
  void drawObjetivos2(TouchyCanvas canvas, Size size) {
    controller.changeSize(size);
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

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    drawObjetivos(myCanvas, size);

    //==============================================================
    // A partir daqui é do jeito antigo !
/*
    List<Rect> listOvals = [];
    List<Path> listPath = [];
    List<Paint> listPaint = [];

    for (int nv = 0; nv < niveis; nv++) {
      final oval = Rect.fromCenter(
        center: c,
        width: (radius / niveis) * (niveis - nv),
        height: (radius / niveis) * (niveis - nv),
      );

      Path p = Path();
      p.moveTo(size.width / 2, size.height / 2);
      p.addArc(oval, 0, 2 * pi);
      p.lineTo(size.width / 2, size.height / 2);
      p.close();

      Paint paintObj = paint_objective;
      listPath.add(p);
      listOvals.add(oval);
      listPaint.add(paintObj);
    }

    for (int nv = 0; nv < niveis; nv++) {
      //canvas.drawRect(listOvals[nv], paint);
      //canvas.drawPath(listPath[nv], lsPaint[1]);
      myCanvas.drawPath(listPath[nv], listPaint[nv] /*lsPaint[nv]*/,
          onTapDown: (tapDownDetails) {
        print("nv --> $nv");
      });
      // var p2 = Paint()
      //   ..color = Colors.black
      //   ..style = PaintingStyle.fill;

      // myCanvas.drawPath(p1,p2);
    }

//aqui
*/

/*
    Path p = Path();
    p.moveTo(size.width / 2, size.height / 2);
    p.addArc(oval, 0, pi / 2);
    p.lineTo(size.width / 2, size.height / 2);
    p.close();

    //TODO - transformar esse método Path de maneira generica
    //TODO - desenhaSecaoPizza(Oval define o nível, start e sweep))
    Path p2 = Path();
    p2.moveTo(size.width / 2, size.height / 2);
    p2.addArc(oval, pi / 2, pi / 2);
    p2.lineTo(size.width / 2, size.height / 2);
    p2.close();

    Path p3 = Path();
    p3.moveTo(size.width / 2, size.height / 2);
    p3.addArc(oval, pi, pi / 2);
    p3.lineTo(size.width / 2, size.height / 2);
    p3.close();

    Path p4 = Path();
    p4.moveTo(size.width / 2, size.height / 2);
    p4.addArc(oval, 3 * pi / 2, pi / 2);
    p4.lineTo(size.width / 2, size.height / 2);
    p4.close();

    Path p5 = Path();
    p5.moveTo(size.width / 2, size.height / 2);
    p5.addArc(oval2, 0, 2 * pi);
    p5.lineTo(size.width / 2, size.height / 2);
    p5.close();

    Path p6 = Path();
    p6.moveTo(size.width / 2, size.height / 2);
    p6.addArc(oval, 3 * pi / 2, pi / 2);
    p6.lineTo(size.width / 2, size.height / 2);
    p6.close();
*/
    // myCanvas.drawPath(p, paint, onTapDown: (tapDownDetails) {
    //   print("vermelho ...");
    // });
    // myCanvas.drawPath(p2, paint2, onTapDown: (tapDownDetails) {
    //   print("azul...");
    // });
    // myCanvas.drawPath(p3, paint3, onTapDown: (tapDownDetails) {
    //   print("roxo...");
    // });
    // myCanvas.drawPath(p4, paint4, onTapDown: (tapDownDetails) {
    //   print("verde...");
    // });
    // myCanvas.drawPath(p6, paint6, onTapDown: (tapDownDetails) {
    //   print("amarelo...");
    // });

    // myCanvas.drawPath(p5, paint5, onTapDown: (tapDownDetails) {
    //   print("preto...");
    // });

    //Desenhar do maior para o menor

    // for (var i = 0; i < objetictive; i++) {
    //   Paint paint = Paint()
    //     ..color = lsColor[i]
    //     ..style = PaintingStyle.stroke;
    //   print("${paint.color}");
    //   lsPaint.add(paint);
    // }
    //canvas.drawRect(oval2, lsPaint.elementAt(3));//random.nextInt(objectives)

    //canvas.drawRect(oval, lsPaint.elementAt(0));

    //canvas.drawArc(oval, degToRad(0), degToRad(90), false,lsPaint[2]);
    //Path path;
    //double startAngle = 0.0;
    //for (var i = 0; i < objetictive; i++) {
    //double sweepAngle = startAngle + degToRad(graus);
    //print("Start ${radToDeg(startAngle)} - $startAngle");
    //print("Sweep ${radToDeg(sweepAngle)} - $sweepAngle");
    //print("========================");
    //path = Path();
    //path.addArc(oval, startAngle, sweepAngle);
    //path.arcTo(oval, startAngle, sweepAngle, false);
    //lsPath.add(path);
    //canvas.drawArc(oval, startAngle, sweepAngle, true, lsPaint[i]);
    //startAngle = sweepAngle;
    //}
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
