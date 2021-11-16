class ACL{

  String? identificador;
  String? permissao;

  ACL({this.identificador, this.permissao});

  ACL.fromJson(Map<String, dynamic> json) {
    identificador = json['identificador'];
    permissao = json['permissao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identificador'] = this.identificador;
    data['permissao'] = this.permissao;

    return data;
  }
}