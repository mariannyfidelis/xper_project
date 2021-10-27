class MetricasPrincipais {

  String? idMetrica;
  String? nomeMetrica;
  double? meta;
  double? realizado;
  double? progresso;
  String? idResultado;

  MetricasPrincipais({this.idMetrica, this.nomeMetrica, this.idResultado, this.meta=0.0, this.realizado=0.0, this.progresso});

  MetricasPrincipais.fromJson(Map<String, dynamic> json) {
    idMetrica = json['idMetrica'];
    nomeMetrica = json['nomeMetrica'];
    meta = json['meta'];
    realizado = json['realizado'];
    progresso= json['progresso'];
    idResultado = json['idResultado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMetrica'] = this.idMetrica;
    data['nomeMetrica'] = this.nomeMetrica;
    data['meta'] = this.meta;
    data['realizado'] = this.realizado;
    data['progresso'] = this.progresso;
    data['idResultado'] = this.idResultado;
    return data;
  }
}