import 'package:flutter/material.dart';

class ObjetivosPrincipais {

  String? idObjetivo;
  String? nome;
  int? progresso;
  int? importancia;
  late double startAngle;
  late double sweepAngle;
  //late Color paint;

  ObjetivosPrincipais({
    required this.idObjetivo,
    required this.nome,
    required this.progresso,
    required this.importancia,
    this.startAngle = 0,
    this.sweepAngle = 360,
    //required this.paint
  });

  ObjetivosPrincipais.fromJson(Map<String, dynamic> json) {
    this.idObjetivo = (json['id_objetivo'] != null) ? json['id_objetivo']: "";
    this.nome = (json['nome'] != null) ? json['nome']: "";
    this.progresso = (json['progresso'] != null) ? json['progresso']: 0;
    this.importancia = (json['importancia'] != null) ? json['importancia'] : 0;
    this.startAngle = (json['startAngle'] != null) ? json['startAngle'] : 0;
    this.sweepAngle = (json['sweepAngle'] != null) ? json['sweepAngle'] : 0;
    //this.paint = (json['paint'] != null) ? (json['paint']) : Colors.white30;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_objetivo'] = this.idObjetivo;
    data['nome'] = this.nome;
    data['progresso'] = this.progresso;
    data['importancia'] = this.importancia;
    data['startAngle'] = this.startAngle;
    data['sweepAngle'] = this.sweepAngle;
    //data['paint'] = this.paint;
    return data;
  }
}
