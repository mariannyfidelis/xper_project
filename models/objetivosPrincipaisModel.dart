class ObjetivosPrincipais {

  String? idObjetivo;
  String? nome;
  int? progresso;
  int? importancia;

  ObjetivosPrincipais({
    required this.idObjetivo,
    required this.nome,
    required this.progresso,
    required this.importancia,
  });

  ObjetivosPrincipais.fromJson(Map<String, dynamic> json) {
    this.idObjetivo = json['id_objetivo'];
    this.nome = json['nome'];
    this.progresso = json['progresso'];
    this.importancia = json['importancia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_objetivo'] = this.idObjetivo;
    data['nome'] = this.nome;
    data['progresso'] = this.progresso;
    data['importancia'] = this.importancia;
    return data;
  }
}
