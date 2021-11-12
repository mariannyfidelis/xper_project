import 'package:cloud_firestore/cloud_firestore.dart';

class ObjetivosPrincipais {
  String? idObjetivo;
  String? nome;
  double? progresso;
  int? importancia;
  double? meta;
  double? realizado;
  late double startAngle;
  late double sweepAngle;
  late Timestamp? dataVencimento;
  List<dynamic>? arquivos = [];
  late String paint;

  ObjetivosPrincipais(
      {required this.idObjetivo,
      required this.nome,
      required this.progresso,
      required this.importancia,
      this.meta = 0.0,
      this.realizado = 0.0,
      this.startAngle = 0,
      this.sweepAngle = 360,
      this.dataVencimento,
      this.arquivos,
      this.paint = "255-242-242-242"});

  ObjetivosPrincipais.fromJson(Map<String, dynamic> json) {
    this.idObjetivo = (json['id_objetivo'] != null) ? json['id_objetivo'] : "";
    this.nome = (json['nome'] != null) ? json['nome'] : "";
    this.progresso = (json['progresso'] != null) ? json['progresso'] : 0;
    this.importancia = (json['importancia'] != null) ? json['importancia'] : 0;
    this.startAngle = (json['startAngle'] != null) ? json['startAngle'] : 0;
    this.sweepAngle = (json['sweepAngle'] != null) ? json['sweepAngle'] : 0;
    this.meta = (json['meta'] != null) ? json['meta'] : 0.0;
    this.realizado = (json['realizado'] != null) ? json['realizado'] : 0.0;
    this.dataVencimento = (json['dataVencimento'] != null)
        ? json['dataVencimento']
        : Timestamp.fromDate(DateTime.now());
    this.paint = (json['paint'] != null) ? (json['paint']) : "255-242-242-242";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_objetivo'] = this.idObjetivo;
    data['nome'] = this.nome;
    data['progresso'] = this.progresso;
    data['importancia'] = this.importancia;
    data['startAngle'] = this.startAngle;
    data['sweepAngle'] = this.sweepAngle;
    data['meta'] = this.meta;
    data['realizado'] = this.realizado;
    data['dataVencimento'] = this.dataVencimento; //dataFormatada;
    data['paint'] = this.paint;
    return data;
  }

  String get dataFormatada {
    var v = this.dataVencimento;
    var value = v!.toDate();
    if (this.dataVencimento == null) {
      value = DateTime.now();
      return "defina a data";
    }

    if (value.day < 10 && (value.month >= 10)) {
      return "0${value.day}/${value.month}/${value.year}";
    }

    if (value.day < 10 && (value.month < 10)) {
      return "0${value.day}/0${value.month}/${value.year}";
    }
    if (value.month < 10) {
      return "${value.day}/0${value.month}/${value.year}";
    }
    return "${value.day}/${value.month}/${value.year}";
  }

  void setDataVencimento(Timestamp newValue) {
    this.dataVencimento = newValue;
  }

  void setStartAngle(double newStartAngle) {
    this.startAngle = newStartAngle;
  }

  void setSweepAngle(double newSweepAngle) {
    this.sweepAngle = newSweepAngle;
  }
}