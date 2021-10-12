import 'dart:ui';

class ObjetivoModel {
  String name;
  int nivel;
  int nivelPai;
  int idObjetivo;
  int idObjetivoPai;
  bool concluido;
  late double importancia;
  late double progresso;
  late DateTime? dataVencimento;
  late List<String> responsaveis;
  late List<String> extensoes;
  late List<String> anotacoes;
  //colocar só os id (chaves primárias) e quando precisar filtra pelo identificador
  late List<ObjetivoModel> objetivosSecundarios;
  double progressoAnterior;
  late double startAngle = 0;
  late double sweepAngle = 360;
  Paint? paint;
  Path? path;
  Rect? oval;
  //falta anexos e dados que foram digitados no ZefirEditor

  ObjetivoModel({
    required this.name,
    required this.nivel,
    required this.nivelPai,
    required this.idObjetivo,
    required this.idObjetivoPai,
    this.concluido = false,
    this.importancia = 0,
    this.progresso = 0,
    this.progressoAnterior = 0,
    this.dataVencimento,
    this.responsaveis = const [],
    this.extensoes = const [],
    this.anotacoes = const [],
    this.objetivosSecundarios = const [], //não foi pensada
    double startAngle = 0,
    double sweepAngle = 360,
    this.paint,
    this.path,
    this.oval,
  });

  //TODO: Ainda precisa melhorar esse Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nivel': nivel,
      'nivelPai': nivelPai,
      'idObjetivo': idObjetivo,
      'idObjetivoPai': idObjetivoPai,
      'concluido': concluido,
      'progressoAnterior': progressoAnterior,
      'paint': paint,
      'path': path,
      'oval': oval,
    };
  }

  //TODO: Ainda precisa melhorar esse Map
  ObjetivoModel.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['name'],
        nivel = firestore['nivel'],
        nivelPai = firestore['nivelPai'],
        idObjetivo = firestore['idObjetivo'],
        idObjetivoPai = firestore['idObjet'],
        concluido = firestore['concluido'],
        progressoAnterior = firestore['progressoAnterior'],
        paint = firestore['paint'],
        path = firestore['path'],
        oval = firestore['oval'];


  String get dataFormatada {
    var value = this.dataVencimento;
    if (this.dataVencimento == null) {
      value = DateTime.now();
      return "defina a data";
    }
    if (value!.day < 10 && (value.month < 10)) {
      return "0${value.day}/0${value.month}/${value.year}";
    }
    if (value.month < 10) {
      return "${value.day}/0${value.month}/${value.year}";
    }
    return "${value.day}/${value.month}/${value.year}";
  }

  Paint? get paints {
    return this.paint;
  }

  Path? get paths {
    return this.path;
  }

  Rect? get ovals {
    return this.oval;
  }

  void concluirObjetivo() {
    concluido = !concluido;
    if (concluido) {
      progresso = 100;
    } else {
      progresso = progressoAnterior;
    }
  }

  void adicionaExtensao(String newExtension) {
    this.extensoes.add(newExtension);
  }

  void removeExtensao(String extension) {
    this.extensoes.removeWhere((element) => element == extension);
  }

  void setNomeObjetivo(String newName) {
    this.name = newName;
  }

  void setImportancia(double newValue) {
    this.importancia = newValue;
  }

  void setProgresso(double newValue) {
    this.progresso = newValue;
  }

  void setStartAngle(double newStartAngle) {
    this.startAngle = newStartAngle;
  }

  void setSweepAngle(double newSweepAngle) {
    this.sweepAngle = newSweepAngle;
  }

  void setDataVencimento(DateTime newValue) {
    this.dataVencimento = newValue;
  }

  void setPath(Path path) {
    this.path = path;
  }

  void setPaint(Paint paint) {
    this.paint = paint;
  }

  void setOval(Rect oval) {
    this.oval = oval;
  }

  void adicionaObjetivoFilho(ObjetivoModel idObjetivoFilho) {
    this.objetivosSecundarios.add(idObjetivoFilho);
  }

  void deletaObjetivoFilho(ObjetivoModel idObjetivoFilho) {
    this
        .objetivosSecundarios
        .removeWhere((element) => element == idObjetivoFilho);
  }
}
