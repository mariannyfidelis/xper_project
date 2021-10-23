class Usuario {
  late String idUsuario;
  late String nome;
  late String email;
  late String urlImagem;
  late String tipoUsuario;
  late bool ativo;

  Usuario(this.idUsuario, this.nome, this.email,
      {this.urlImagem = "", this.tipoUsuario = "client", this.ativo = true});

  Usuario.fromFirestore(Map<String, dynamic> firestore)
      //mudei de user para firestore
      : idUsuario = firestore["idUsuario"], //tirei o { e o this
        nome = firestore["nome"],
        email = firestore["email"],
        urlImagem = firestore["urlImagem"],
        tipoUsuario = firestore["tipoUsuario"],
        ativo = firestore["ativo"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this.idUsuario,
      "nome": this.nome,
      "email": this.email,
      "urlImagem": this.urlImagem,
      "tipoUsuario": this.tipoUsuario,
      "ativo": this.ativo
    };
    return map;
  }
}
