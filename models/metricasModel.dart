class MetricasPrincipais {
  String? idMetrica;
  String? nomeMetrica;
  double? meta1;
  double? meta2;
  double? meta3;
  double? meta4;
  double? realizado1;
  double? realizado2;
  double? realizado3;
  double? realizado4;
  String? unidadeMedida;
  double? progresso;
  String? idResultado;

  MetricasPrincipais(
      {this.idMetrica,
        this.nomeMetrica,
        this.idResultado,
        this.meta1 = 0.0,
        this.meta2 = 0.0,
        this.meta3 = 0.0,
        this.meta4 = 0.0,
        this.realizado1 = 0.0,
        this.realizado2 = 0.0,
        this.realizado3 = 0.0,
        this.realizado4 = 0.0,
        this.unidadeMedida = 'Unidade Padrão',
        this.progresso});

  MetricasPrincipais.fromJson(Map<String, dynamic> json) {
    idMetrica = json['idMetrica'];
    nomeMetrica = json['nomeMetrica'];
    meta1 = json['meta1'];
    meta2 = json['meta2'];
    meta3 = json['meta3'];
    meta4 = json['meta4'];
    realizado1 = json['realizado1'];
    realizado2 = json['realizado2'];
    realizado3 = json['realizado3'];
    realizado4 = json['realizado4'];
    progresso = json['progresso'];
    idResultado = json['idResultado'];
    unidadeMedida = json['unidadeMedida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idMetrica'] = this.idMetrica;
    data['nomeMetrica'] = this.nomeMetrica;
    data['meta1'] = this.meta1;
    data['meta2'] = this.meta2;
    data['meta3'] = this.meta3;
    data['meta4'] = this.meta4;
    data['realizado1'] = this.realizado1;
    data['realizado2'] = this.realizado2;
    data['realizado3'] = this.realizado3;
    data['realizado4'] = this.realizado4;
    data['progresso'] = this.progresso;
    data['idResultado'] = this.idResultado;
    data['unidadeMedida'] = this.unidadeMedida;
    return data;
  }
}