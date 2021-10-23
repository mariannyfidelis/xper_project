//String das permissões --> {read, owner, write}

class ACL{

  String? idDonoResultadoMetrica;
  String? permissao;

  ACL({this.idDonoResultadoMetrica, this.permissao});

  ACL.fromJson(Map<String, dynamic> json) {
    idDonoResultadoMetrica = json['idDonoResultadoMetrica'];
    permissao = json['permissao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDonoResultadoMetrica'] = this.idDonoResultadoMetrica;
    data['permissao'] = this.permissao;

    return data;
  }
}