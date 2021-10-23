class ResultadosPrincipais {

  String? idResultado;
  String? nomeResultado;
  String? idObjetivoPai;
  String? idMetrica;
  List? donoResultado;

  ResultadosPrincipais(
      {required this.idResultado,
        required this.nomeResultado,
        required this.idObjetivoPai,
        required this.idMetrica,
        required this.donoResultado,
        });

  ResultadosPrincipais.fromJson(Map<String, dynamic> json) {
    idResultado = json['idResultado'];
    nomeResultado = json['nomeResultado'];
    donoResultado = json['donoResultado'];
    idObjetivoPai = json['idObjetivoPai'];
    idMetrica = json['idMetrica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idResultado'] = this.idResultado;
    data['nomeResultado'] = this.nomeResultado;
    data['donoResultado'] = this.donoResultado;
    data['idObjetivoPai'] = this.idObjetivoPai;
    data['idMetrica'] = this.idObjetivoPai;

    return data;
  }
}