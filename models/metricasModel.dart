class MetricasPrincipais {

  String? idMetrica;
  String? nomeMetrica;
  double? meta;
  double? realizado;
  double? progresso;

  MetricasPrincipais({this.idMetrica, this.nomeMetrica, this.meta, this.realizado, this.progresso});

  MetricasPrincipais.fromJson(Map<String, dynamic> json) {
    idMetrica = json['idMetrica'];
    nomeMetrica = json['nomeMetrica'];
    meta = json['meta'];
    realizado = json['realizado'];
    progresso= json['progresso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMetrica'] = this.idMetrica;
    data['nomeMetrica'] = this.nomeMetrica;
    data['meta'] = this.meta;
    data['realizado'] = this.realizado;
    data['progresso'] = this.progresso;
    return data;
  }
}