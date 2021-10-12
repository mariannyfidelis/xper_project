import 'dart:typed_data';
import '/models/usuario.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool cadastrarUsuario = false;
  String erroMsg = "";
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerName = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //ValuesStore v = ValuesStore();
  Uint8List? _arquivoImagemSelecionado;

  void escreverDados() {
    //FirebaseFirestore firestore = FF
  }

  void _verificarUsuarioLogado() async {
    User? usuarioLogado = await _auth.currentUser;
    if (usuarioLogado != null) {
      verificaTipoUsuario(usuarioLogado);
      //Navigator.pushReplacementNamed(context, "/home");
    }
  }

  void verificaTipoUsuario(User? user) async {
    //Verificar e redirecionar para a tela específica
    String uidUser = user!.uid;
    DocumentSnapshot us =
        await _firestore.collection("usuarios").doc("$uidUser").get();

    String tipo = us.get("tipoUsuario");
    print("xxx tipo do usuário $tipo");

    //QuerySnapshot snapshot =
    //  await _firestore.collection("usuarios/$uidUser").get();
    if (tipo == "admin") {
      Navigator.pushReplacementNamed(context, "/dashboard");
    } else if (tipo == "gerenciador") {
      Navigator.pushReplacementNamed(context, "/gerenciador");
    } else if (tipo == "cliente") {
      Navigator.pushReplacementNamed(context, "/projetos");
    }
  }

  void _selecionarImagem() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    //Recuperar arquivo
    setState(() {
      _arquivoImagemSelecionado = resultado?.files.single.bytes;
    });
  }

  void _uploadImagem(Usuario usuario) {

    Uint8List? arquivoSelecionado = _arquivoImagemSelecionado;
    FirebaseStorage _storage = FirebaseStorage.instance;

    if (arquivoSelecionado != null) {
      Reference imagePerfilRef = _storage
          .ref("imagens/perfil/${usuario.idUsuario}/${usuario.idUsuario}.jpg");
      UploadTask uploadtask = imagePerfilRef.putData(arquivoSelecionado);
      uploadtask.whenComplete(() async {
        String urlImagem = await uploadtask.snapshot.ref.getDownloadURL();
        print("deu certo taí o link $urlImagem!!!");
        usuario.urlImagem = urlImagem;

        final usuariosRef = _firestore.collection("usuarios");
        usuariosRef
            .doc("${usuario.idUsuario}")
            .set(usuario.toMap())
            .then((value) {
          //Rotas para outra tela
          Navigator.pushReplacementNamed(context, "/projetos");
        });
      });
    } else {
      String urlImagem = usuario.urlImagem;
      print("deu certo taí o link $urlImagem!!!");
      final usuariosRef = _firestore.collection("usuarios");
      usuariosRef
          .doc("${usuario.idUsuario}")
          .set(usuario.toMap())
          .then((value) {
        //Rotas para outra tela
        Navigator.pushReplacementNamed(context, "/projetos");
      });
    }
  }

  void _validarCampos() async {
    String nome = _controllerName.text;
    String email = _controllerEmail.text;
    String senha = _controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        if (cadastrarUsuario) {
          //cadastrar
          if (_arquivoImagemSelecionado != null) {
            if (nome.isNotEmpty && nome.length > 6) {
              await _auth
                  .createUserWithEmailAndPassword(
                email: email,
                password: senha,
              )
                  .then((userCredencial) {
                String? idUsuario = userCredencial.user?.uid;
                print("Usuário cadastrado: $idUsuario");

                _auth.currentUser?.sendEmailVerification().then(
                    (value) => print("enviei um email de verificação ..."));

                //Upload da imagem
                if (idUsuario != null) {
                  Usuario usuario = Usuario(idUsuario, nome, email, tipoUsuario: "cliente", ativo: true);
                  _uploadImagem(usuario);
                }
              });
            } else {
              print("Nome inválido digite 6 ou mais caracteres!");
            }
          } else {
            print("Selecione uma imagem !");
          }
        } else {
          //logar usuário
          logarEmailSenha(email, senha);
        }
      } else {
        print("Senha inválida !");
      }
    } else {
      print("Preencha os campos de email e senha !");
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: PaletaCores.corPrimaria,
          width: larguraTela,
          height: alturaTela,
          child: Observer(builder: (context) {
            return Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    height: alturaTela * 0.4,
                    width: larguraTela,
                    color: PaletaCores.corPrimaria,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: 650,
                          height: alturaTela * 0.7,
                          child: Padding(
                            padding: EdgeInsets.all(36),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: cadastrarUsuario,
                                    child: ClipOval(
                                      child: _arquivoImagemSelecionado != null
                                          ? Image.memory(
                                              _arquivoImagemSelecionado!,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Image.asset(
                                              "images/perfil.png",
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.fitHeight,
                                            ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Visibility(
                                    visible: cadastrarUsuario,
                                    child: Column(
                                      children: [
                                        OutlinedButton.icon(
                                            onPressed: _selecionarImagem,
                                            icon: Icon(Icons.cached),
                                            label: Text("Selecionar foto")),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: cadastrarUsuario,
                                    child: TextField(
                                      keyboardType: TextInputType.name,
                                      controller: _controllerName,
                                      decoration: InputDecoration(
                                        //hintText: "Nome",
                                        labelText: "Nome",
                                        suffixIcon: Icon(Icons.person_outline),
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.name,
                                    controller: _controllerEmail,
                                    decoration: InputDecoration(
                                        //hintText: "Email",
                                        labelText: "Email",
                                        suffixIcon: Icon(Icons.mail_outline)),
                                  ),
                                  TextField(
                                    obscureText: true,
                                    keyboardType: TextInputType.name,
                                    controller: _controllerPassword,
                                    decoration: InputDecoration(
                                      //hintText: "Senha",
                                      labelText: "Senha",
                                      suffixIcon: Icon(Icons.lock_outline),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _validarCampos();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: PaletaCores.corPrimaria),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          cadastrarUsuario
                                              ? "Cadastrar"
                                              : "Logar",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Login"),
                                      Switch(
                                          value: cadastrarUsuario,
                                          onChanged: (valor) {
                                            setState(() {
                                              cadastrarUsuario = valor;
                                            });
                                          }),
                                      Expanded(child: Text("Cadastro Freemium")),
                                      //SizedBox(width: 70),
                                      Visibility(
                                        visible: !cadastrarUsuario,
                                        child: OutlinedButton(
                                            onPressed: () {
                                              redefinirSenha();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                 primary: Colors.white30),
                                            child: Text("Esqueceu sua senha", style: TextStyle(color: PaletaCores.corPrimaria),),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Visibility(
                                    visible: !cadastrarUsuario,
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                          primary: PaletaCores.corPrimaria),
                                      onPressed: () {
                                        logarContaGoogle();
                                      },
                                      icon: Icon(Icons.login),
                                      label:
                                          Text("Logar com a conta do google"),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Visibility(
                                    visible: false,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        logout();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: PaletaCores.corPrimaria),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Deslogar",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void redefinirSenha() {
    print("Redefina sua senha ...");
    Navigator.pushReplacementNamed(context, "/redefinicaoSenha");
  }

  void logarEmailSenha(String email, String senha) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) async {
      print("Logado como: ${value.user?.uid} de email: ${value.user?.email}");
      User? usuarioLogado = value.user;

      verificaTipoUsuario(usuarioLogado);
    }).catchError((error) {
      print(error);
      print("Aconteceu algum problema ao logar ...");
      setState(() {
        erroMsg = "email ou senha incorreta";
      });
    });
  }

  void logarContaGoogle() {
    var provider = GoogleAuthProvider();
    //provider.addScope("'https://www.googleapis.com/auth/contacts.readonly'");
    _auth.signInWithPopup(provider).then((resultado) {
      var idUsuario = resultado.user?.uid;
      print("Usuário cadastrado pelo google: $idUsuario");
      _auth.currentUser
          ?.sendEmailVerification()
          .then((value) => print("enviei um email de verificação 2 ..."));

      //Upload da imagem
      if (idUsuario != null) {
        Usuario usuario = Usuario(
          idUsuario,
          resultado.user!.displayName.toString(),
          resultado.user!.email.toString(),
          urlImagem: resultado.user!.photoURL.toString(),
          tipoUsuario: "cliente",
          ativo: true,
        );
        _uploadImagem(usuario);
        print("Logado como google email ${resultado.user?.email}");
      }else{

      }
    });
  }

  void logout() {
    _auth.signOut();
    _controllerName.text = "";
    _controllerEmail.text = "";
    _controllerPassword.text = "";
  }

}
