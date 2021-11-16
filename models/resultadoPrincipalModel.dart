class ResultadosPrincipais {
  String? idResultado;
  String? nomeResultado;
  String? idObjetivoPai;
  List? donoResultado;
  List? extensao;
  double? meta;
  double? meta1;
  double? meta2;
  double? meta3;
  double? meta4;
  double? realizado;
  double? realizado1;
  double? realizado2;
  double? realizado3;
  double? realizado4;
  double? progresso;
  double startAngle = 0.0;
  double sweepAngle = 360.0;
  List<dynamic>? arquivos = [];
  late String paint;

  ResultadosPrincipais({
    required this.idResultado,
    required this.nomeResultado,
    required this.idObjetivoPai,
    required this.donoResultado,
    this.meta = 0.0,
    this.meta1 = 0.0,
    this.meta2 = 0.0,
    this.meta3 = 0.0,
    this.meta4 = 0.0,
    this.realizado = 0.0,
    this.realizado1 = 0.0,
    this.realizado2 = 0.0,
    this.realizado3 = 0.0,
    this.realizado4 = 0.0,
    this.progresso = 0.0,
    this.startAngle= 0.0,
    this.sweepAngle= 360.0,
    this.arquivos,
    this.paint="255-242-242-242",
    this.extensao
  });

  ResultadosPrincipais.fromJson(Map<String, dynamic> json) {
    idResultado = json['idResultado'];
    nomeResultado = json['nomeResultado'];
    donoResultado = (json['donoResultado'] != null) ? json['donoResultado']:[];
    idObjetivoPai = json['idObjetivoPai'];
    realizado = json['realizado'];
    realizado1 = json['realizado1'];
    realizado2 = json['realizado2'];
    realizado3 = json['realizado3'];
    realizado4 = json['realizado4'];
    meta = json['meta'];
    meta1 = json['meta1'];
    meta2 = json['meta2'];
    meta3 = json['meta3'];
    meta4 = json['meta4'];
    arquivos = (json['arquivos'] != null) ? json['arquivos']: [];
    progresso = json['progresso'];
    startAngle = (json['startAngle'] != null) ? json['startAngle'] : 0.0;
    sweepAngle = (json['sweepAngle'] != null) ? json['sweepAngle'] : 0.0;
    paint = (json['paint'] != null) ? (json['paint']) : "255-242-242-242";
    extensao = (json['extensao'] != null) ? (json['extensao']): [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idResultado'] = this.idResultado;
    data['nomeResultado'] = this.nomeResultado;
    data['donoResultado'] = this.donoResultado;
    data['idObjetivoPai'] = this.idObjetivoPai;
    data['meta'] = this.meta;
    data['meta1'] = this.meta1;
    data['meta2'] = this.meta2;
    data['meta3'] = this.meta3;
    data['meta4'] = this.meta4;
    data['realizado'] = this.realizado;
    data['realizado1'] = this.realizado1;
    data['realizado2'] = this.realizado2;
    data['realizado3'] = this.realizado3;
    data['realizado4'] = this.realizado4;
    data['progresso'] = this.progresso;
    data['startAngle'] = this.startAngle;
    data['sweepAngle'] = this.sweepAngle;
    data['paint'] = this.paint;
    data['arquivos'] = this.arquivos;
    data['extensao'] = this.extensao;

    return data;
  }

  void setStartAngle(double newStartAngle) {
    this.startAngle = newStartAngle;
  }

  void setSweepAngle(double newSweepAngle) {
    this.sweepAngle = newSweepAngle;
  }
}