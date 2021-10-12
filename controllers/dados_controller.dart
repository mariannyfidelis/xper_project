import 'dart:math';
import '/models/objetivo_model.dart';
import 'package:flutter/material.dart';

//Definindo graus para cada fatia
// double objetictive = 6;
// double p = (100 / objetictive);
// double graus = (360 * p) / 100;
//rever o calculo graus = 360/objetivos

class ObjectiveController extends ChangeNotifier {
  int niveis = 1; //pq a lista já tem um elemento
  int nv = 0; //niveis - 1
  int ultimoNivelClicado = 0;
  int numeroTotalObjetivos = 1;

  bool visivel = true;
  bool clicou = false;
  String detalhes = "ocultar detalhes";
  IconData iconDetalhes = Icons.arrow_drop_up_rounded;

  Size? sizeScreen;
  late Offset centro;
  late double radius;
  late BuildContext context;

  List<ObjetivoModel> objs = [
    new ObjetivoModel(
        name: "Objetivo Principal",
        nivel: 1,
        nivelPai: 0,
        idObjetivo: 1,
        idObjetivoPai: 0,
        startAngle: 0,
        sweepAngle: 360,
        paint: Paint()
          ..strokeWidth = 30
          ..color = Color.fromRGBO(250, 250, 250, 1)
          ..style = PaintingStyle.fill
          ..strokeJoin = StrokeJoin.round,
        objetivosSecundarios: [])
  ];
/*..shader = LinearGradient(
            colors: [Colors.grey, Colors.white, Colors.grey],
            stops: [0.0, 0.3, 1.0]).createShader(criaOval(1, 0))*/
  void configuraContext(BuildContext newContext) {
    this.context = newContext;
  }

  Paint criaPaintObjective() {
    var r = Random().nextInt(55) + 200;
    var g = Random().nextInt(55) + 200;
    var b = Random().nextInt(55) + 200;
    Paint p = Paint()
      ..strokeWidth = 30
      ..color = Color.fromRGBO(r, g, b, 1)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;
    return p;
  }

  void addObjetivo2() {
    // var oval = criaOval(niveis, nv);
    // Path p = Path();
    // Size? size = this.sizeScreen;
    // p.moveTo(size!.width / 2, size.height / 2);
    // p.addArc(oval, 0, 2 * pi);
    // p.lineTo(size.width / 2, size.height / 2);
    // p.close();
    nv = niveis;
    niveis = niveis + 1;
    ultimoNivelClicado = niveis - 1;
    numeroTotalObjetivos += 1;

    Paint paintObj = criaPaintObjective();

    ObjetivoModel objetivoModel = ObjetivoModel(
      name: "Objetivo $niveis",
      nivel: niveis,
      nivelPai: nv,
      idObjetivo: numeroTotalObjetivos,
      idObjetivoPai: ultimoNivelClicado,
      paint: paintObj,
      //path: p,
      //oval: oval,
    );
    objetivoModel.setPaint(paintObj);
    // objetivoModel.setPath(p);
    // objetivoModel.setOval(oval);

    objs.add(objetivoModel);
    print("ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

    notifyListeners();
  }

  void addObjetivoTentativaFinal() {
    print("xxxxxxxxxxxxxxxxxxxxxxxx");
    print("xx ultimo nívellllll - $ultimoNivelClicado");
    ObjetivoModel objetivoClicado = objs[ultimoNivelClicado];
    //List<ObjetivoModel> objetivosFilhos = objetivoClicado.objetivosSecundarios;
    List<ObjetivoModel> list_Filhos = [];
    List<ObjetivoModel> list_Irmaos = [];

    for (ObjetivoModel objetivoAtual in objs) {
      //Será apenas uma lista de objetivos para a navegação ser mais rápida
      if (objetivoAtual.nivelPai == ultimoNivelClicado + 1) {
        //if (objetivoAtual.nivelPai == objetivoClicado.nivel){
        list_Filhos.add(objetivoAtual); //quem está dentro dessa lista é irmão
      }
    } //Saio do FOR com os objetivos filhos
    if (list_Filhos.isEmpty) {
      print("xx objetivo atual não tem filho");
      var startAngle = objetivoClicado.startAngle;
      var sweepAngle = objetivoClicado.sweepAngle;

      Paint paintObj = criaPaintObjective();
      print("xx Paint ${paintObj.color}");
      var startAngleFilho = startAngle;
      var sweepAngleFilho = sweepAngle;

      double importancia = 100.0;
      double progresso = 0;

      nv = niveis;
      niveis = niveis + 1;
      numeroTotalObjetivos += 1;

      print("xx start pai [$startAngleFilho] e sweep pai [$sweepAngleFilho]");
      print("xx importancia - $importancia");
      print("xx progresso - $progresso");
      print("xx nv - $nv");
      print("xx niveis $niveis");
      print("xx ultimoNivelClicado $ultimoNivelClicado");
      print("xx numeroTotalObjetivos $numeroTotalObjetivos");

      ObjetivoModel objetivoModel = ObjetivoModel(
        name: "Objetivo $numeroTotalObjetivos",
        nivel: niveis,
        nivelPai: nv,
        idObjetivo: numeroTotalObjetivos,
        idObjetivoPai: ultimoNivelClicado,
        importancia: importancia,
        progresso: progresso,
        startAngle: startAngleFilho,
        sweepAngle: sweepAngleFilho,
        paint: paintObj,
        objetivosSecundarios: [],
      );

      ultimoNivelClicado = niveis -
          1; //acho que tá errado, tem que ser na sequência que foi criado !

      print("xx criei um novo objetivo [ ${objetivoModel.name}] ");
      objetivoModel.setPaint(paintObj);
      print("xx setei o paint");
      objs.add(objetivoModel);
      print("xx tamanho de objs - [${objs.length}]");
      print("xx Informações do objetivo clicado - [${objetivoClicado.name}]");
      print(
          "xx qtd de filhos do objetivo clicado - ${objetivoClicado.objetivosSecundarios.length}");
      print("xx ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

      objetivoClicado.objetivosSecundarios.add(objetivoModel);
      print("xx criei um obj secundario");
      print(
          "xx qtd de filhos do objetivo clicado - ${objetivoClicado.objetivosSecundarios.length}");
      print("xxxxxxxxxxxxxxxxxxxxxxxx");

      notifyListeners();
    }
  }

  void addObjetivo() {
    print("xxxxxxxxxxxxxxxxxxxxxxxx");
    print("xx ultimo nívellllll - $ultimoNivelClicado");
    ObjetivoModel objetivoClicado = objs[ultimoNivelClicado];
    List<ObjetivoModel> objetivosFilhos = objetivoClicado.objetivosSecundarios;

    if (objetivosFilhos.isEmpty) {
      print("xx objetivo atual não tem filho");
      var startAngle = objetivoClicado.startAngle;
      var sweepAngle = objetivoClicado.sweepAngle;

      Paint paintObj = criaPaintObjective();
      print("xx Paint ${paintObj.color}");
      var startAngleFilho = startAngle;
      var sweepAngleFilho = sweepAngle;

      double importancia = 100.0;
      double progresso = 0;

      nv = niveis;
      niveis = niveis + 1;
      numeroTotalObjetivos += 1;

      print("xx start pai [$startAngleFilho] e sweep pai [$sweepAngleFilho]");
      print("xx importancia - $importancia");
      print("xx progresso - $progresso");
      print("xx nv - $nv");
      print("xx niveis $niveis");
      print("xx ultimoNivelClicado $ultimoNivelClicado");
      print("xx numeroTotalObjetivos $numeroTotalObjetivos");

      ObjetivoModel objetivoModel = ObjetivoModel(
        name: "Objetivo $numeroTotalObjetivos",
        nivel: niveis,
        nivelPai: nv,
        idObjetivo: numeroTotalObjetivos,
        idObjetivoPai: ultimoNivelClicado,
        importancia: importancia,
        progresso: progresso,
        startAngle: startAngleFilho,
        sweepAngle: sweepAngleFilho,
        paint: paintObj,
        objetivosSecundarios: [],
      );

      ultimoNivelClicado = niveis - 1;

      print("xx criei um novo objetivo [ ${objetivoModel.name}] ");
      objetivoModel.setPaint(paintObj);
      print("xx setei o paint");
      objs.add(objetivoModel);
      print("xx tamanho de objs - [${objs.length}]");
      print("xx Informações do objetivo clicado - [${objetivoClicado.name}]");
      print(
          "xx qtd de filhos do objetivo clicado - ${objetivoClicado.objetivosSecundarios.length}");
      print("xx ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

      objetivoClicado.objetivosSecundarios.add(objetivoModel);
      print("xx criei um obj secundario");
      print(
          "xx qtd de filhos do objetivo clicado - ${objetivoClicado.objetivosSecundarios.length}");
      print("xxxxxxxxxxxxxxxxxxxxxxxx");
      notifyListeners();
    } else {
      print("xx ********** NIVEL IRMAO ********************");
      print("xx objetivo atual tem pelo menos um filho");

      int nivelPai = objetivoClicado.nivel;

      double startAnglePai = objetivoClicado.startAngle;
      double sweepAnglePai = objetivoClicado.sweepAngle;

      Paint paintObj = criaPaintObjective();

      double finalAngle = startAnglePai + sweepAnglePai;
      double sweepNivel =
          (finalAngle - startAnglePai) / (objetivosFilhos.length + 1);

      double importancia = 100 / (objetivosFilhos.length + 1);
      double progresso = 0;
      double startAngleFilho = startAnglePai;

      print("xx start pai [$startAngleFilho] e sweep pai [$sweepAnglePai]");
      print("xx final Angle - [$finalAngle] e sweep do Nivel - [$sweepNivel]");
      print("xx importancia - $importancia");
      print("xx progresso - $progresso");
      print("xx nv - $nv");
      print("xx niveis $niveis");
      print("xx ultimoNivelClicado $ultimoNivelClicado");

      numeroTotalObjetivos += 1;
      print("xx numeroTotalObjetivos $numeroTotalObjetivos");

      ObjetivoModel objetivoModel = ObjetivoModel(
        name: "Objetivo $numeroTotalObjetivos",
        nivel: nivelPai + 1,
        nivelPai: nivelPai,
        idObjetivo: numeroTotalObjetivos,
        idObjetivoPai: ultimoNivelClicado, //verificar se tá correto
        importancia: importancia,
        progresso: progresso,
        startAngle: startAngleFilho,
        sweepAngle: sweepNivel,
        paint: paintObj,
        objetivosSecundarios: [],
      );
      print("xx nivel - ${objetivoModel.nivel}");
      print("xx nivelPai ${objetivoModel.nivelPai}");

      objs.add(objetivoModel);
      objetivoClicado.objetivosSecundarios.add(objetivoModel);
      print("xx criei um obj secundario");
      print("xx Informações do objetivo clicado - [${objetivoClicado.name}]");
      print(
          "xx qtd de filhos do objetivo clicado - ${objetivoClicado.objetivosSecundarios.length}");
      print("xx qtd de objetivos total na lista - ${objs.length}");
      print("xx ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

      int q = 1;

      for (ObjetivoModel filho in objetivoClicado.objetivosSecundarios) {
        filho.setStartAngle(startAngleFilho);
        filho.setSweepAngle(sweepNivel);
        startAngleFilho += sweepNivel;
        print(
            "xx -iteracao de atualizacao $q - Atualizei o objetivo ${filho.name}");

        print(
            "xx start dele [${filho.startAngle}] e sweep dele [${filho.sweepAngle}]");
        q++;
      }
      print("xxxxxxxxxxxxxxxxxxxxxxxx");
      //notifyListeners(); //Sera que precisa desse notify ou coloca no final ?
    }
    for (ObjetivoModel objAtual in objs) {
      print("xx ----- verificando o objs");
      print(
          "xx ${objAtual.name} | start dele [${objAtual.startAngle}] e sweep dele [${objAtual.sweepAngle}]");
    }
    print("xxxxxxxxxxxxxxxxxxxxxxxx");
    //Atualizar todos os objetivos
    for (ObjetivoModel objetivoAtual in objs) {
      print("xx --------------------------------------------------");
      print("xx Atualizando o objetivo [${objetivoAtual.name}]");
      print(
          "xx Nivel do ObjAtual ${objetivoAtual.nivel} | UltNivelClicado $ultimoNivelClicado");
      if (objetivoAtual.nivel < ultimoNivelClicado) {
        print("xx Objetivo atual tem nível menor que o nivel clicado");
        //return;
      } else {
        double startAngleFilho = objetivoAtual.startAngle;
        double sweepAngleFilho = objetivoAtual.sweepAngle;
        int length = objetivoAtual.objetivosSecundarios.length;
        print("xx StartAngle - $startAngleFilho");
        print("xx SweepAngle - $sweepAngleFilho");
        print("xx Quantidade de filhos - length - $length");

        if (length >= 1) {
          double finalAngleNivel = startAngleFilho + sweepAngleFilho;
          double sweepNivel = (finalAngleNivel - startAngleFilho) / length;

          print("xx FinalAngle do Nivel - $finalAngleNivel");
          print("xx Sweep do Nivel - $sweepNivel");

          for (ObjetivoModel objetivoFilho
          in objetivoAtual.objetivosSecundarios) {
            objetivoFilho.setStartAngle(startAngleFilho);
            objetivoFilho.setSweepAngle(sweepNivel);
            startAngleFilho += sweepNivel;
            print("xx StartAngle - $startAngleFilho");
          }
        } else {
          print("O [${objetivoAtual.name}] ainda nao tem filhos !");
        }
      }
    }
    print("xx --------------------------------------------------");
    notifyListeners();
  }

  void delObjetivo() {
    if (niveis > 1) {
      objs.removeLast();
      niveis = niveis - 1;
      nv = nv - 1;
      numeroTotalObjetivos -= 1;
      ultimoNivelClicado = niveis;
      notifyListeners();
    } else {
      niveis = 1;
      nv = 0;
      numeroTotalObjetivos = 1;
      ultimoNivelClicado = niveis;
      print("ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

      notifyListeners();
    }
  }

  void addObjetivoProximo() {
    Paint p = Paint()
      ..strokeWidth = 30
      ..color = Color.fromRGBO(255, 100, 100, 1)
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round;

    ObjetivoModel objeto = objs.elementAt(ultimoNivelClicado);

    var nivelAtual = ultimoNivelClicado + 1;

    ObjetivoModel newObjetivo = new ObjetivoModel(
      name: "Objetivo $numeroTotalObjetivos",
      nivel: nivelAtual,
      nivelPai: objeto.nivelPai,
      idObjetivo: numeroTotalObjetivos,
      idObjetivoPai: objeto.nivelPai,
      paint: p,
    );

    numeroTotalObjetivos += 1;
    newObjetivo.setPaint(p);
    objs.add(
        newObjetivo); //Verificar a possibilidade de ordenar para sempre fiacr organizado
    List<ObjetivoModel> objetivosDoNivel = [];

    for (ObjetivoModel objetivo in objs) {
      if (objetivo.nivel == nivelAtual) {
        objetivosDoNivel.add(objetivo);
      }
    }
    double sweepFatia = 360 / objetivosDoNivel.length;
    double startAngle = 0;

    for (ObjetivoModel objetivo in objetivosDoNivel) {
      objetivo.setStartAngle(startAngle);
      objetivo.setSweepAngle(sweepFatia);
      //TODO - falta configurar aqui o progresso e a importância
      startAngle += sweepFatia;
      //sweep += sweep_fatia
    }

    //objeto.adicionaObjetivoFilho();
    print(
        "%% - nome: ${objeto.name} - nível ${objeto.nivel} - nível do Pai ${objeto.nivelPai}");
    print("ultimo nivel clicado e armazenado é [$ultimoNivelClicado]");

    //Aqui deixa colorido quando clica em um determinado nível
    //objs[ultimoNivelClicado].setPaint(p);

    notifyListeners();
  }

  void delObjetivoProximo() {}

  void updateObjetivo() {
    //aqui  .... Será ao clicar eu tenho que saber que estou na referência
    //daquele objetivo que eu cliquei !
  }

  List<ObjetivoModel> getObjetivos() {
    return objs;
  }

  void changeImportancia(double newValue, ObjetivoModel objetivoModel) {
    objetivoModel.setImportancia(newValue);
    notifyListeners();
  }

  void changeProgresso(double newValue, ObjetivoModel objetivoModel) {
    objetivoModel.setProgresso(newValue);
    notifyListeners();
  }

  void changeVisibilidade() {
    visivel = !visivel;
    clicou = !clicou;
    if (!visivel) {
      detalhes = "mostrar detalhes";
      iconDetalhes = Icons.arrow_drop_down_rounded;
    } else {
      detalhes = "ocultar detalhes";
      iconDetalhes = Icons.arrow_drop_up_rounded;
    }
    notifyListeners();
  }

  void changeDataVencimento(DateTime dateTime, ObjetivoModel objetivoModel) {
    objetivoModel.setDataVencimento(dateTime);
    notifyListeners();
  }

  void changeSize(Size size) {
    this.sizeScreen = size;
    this.centro = Offset(size.width / 2, size.height / 2);
    this.radius = size.width * 0.8;
    notifyListeners();
  }

  void concluirObjetivo(ObjetivoModel objetivoModel) {
    objetivoModel.concluirObjetivo();
    notifyListeners();
  }

  Size? get size {
    return this.sizeScreen;
  }
}
