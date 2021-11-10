class ResultadosPrincipais {
  String? idResultado;
  String? nomeResultado;
  String? idObjetivoPai;
  // String? idMetrica;
  List? donoResultado;
  double? meta;
  double? realizado;
  double? progresso;
  double startAngle=0.0;
  double sweepAngle=360.0;
  late String paint;

  ResultadosPrincipais({
    required this.idResultado,
    required this.nomeResultado,
    required this.idObjetivoPai,
    // required this.idMetrica,
    required this.donoResultado,
    this.meta = 0.0,
    this.realizado = 0.0,
    this.progresso = 0.0,
    this.startAngle= 0.0,
    this.sweepAngle= 360.0,
    this.paint="255-242-242-242"
  });

  ResultadosPrincipais.fromJson(Map<String, dynamic> json) {
    idResultado = json['idResultado'];
    nomeResultado = json['nomeResultado'];
    donoResultado = json['donoResultado'];
    idObjetivoPai = json['idObjetivoPai'];
    realizado = json['realizado'];
    meta = json['meta'];
    progresso = json['progresso'];
    startAngle = (json['startAngle'] != null) ? json['startAngle'] : 0.0;
    sweepAngle = (json['sweepAngle'] != null) ? json['sweepAngle'] : 0.0;
    paint = (json['paint'] != null) ? (json['paint']) : "255-242-242-242";
    // idMetrica = json['idMetrica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idResultado'] = this.idResultado;
    data['nomeResultado'] = this.nomeResultado;
    data['donoResultado'] = this.donoResultado;
    data['idObjetivoPai'] = this.idObjetivoPai;
    data['meta'] = this.meta;
    data['realizado'] = this.realizado;
    data['progresso'] = this.progresso;
    data['startAngle'] = this.startAngle;
    data['sweepAngle'] = this.sweepAngle;
    data['paint'] = this.paint;
    // data['idMetrica'] = this.idObjetivoPai;
    return data;
  }

  void setStartAngle(double newStartAngle) {
    this.startAngle = newStartAngle;
  }

  void setSweepAngle(double newSweepAngle) {
    this.sweepAngle = newSweepAngle;
  }
}
