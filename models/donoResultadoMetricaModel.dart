class DonosResultadoMetricas {
  String? id;
  String? nome;
  String? email;
  //TODO: permissão será aqui ? 

  DonosResultadoMetricas({this.nome, this.id, this.email});

  DonosResultadoMetricas.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}