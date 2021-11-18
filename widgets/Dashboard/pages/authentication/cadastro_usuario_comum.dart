import 'dart:typed_data';
import 'package:get/get.dart';
import '/models/usuario.dart';
import '/utils/paleta_cores.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CadastroPageUsuario extends StatefulWidget {
  CadastroPageUsuario({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CadastroPageeUsuarioState createState() => _CadastroPageeUsuarioState();
}

class _CadastroPageeUsuarioState extends State<CadastroPageUsuario> {
  AuthService controllerAuth = Get.find<AuthService>();
  bool cadastrarUsuario = false;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Uint8List? _arquivoImagemSelecionado;

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

  void _selecionarImagem() async {
    FilePickerResult? resultado = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    //Recuperar arquivo
    setState(() {
      _arquivoImagemSelecionado = resultado?.files.single.bytes;
    });
  }

  void _validarCampos() async {
    String nome = _controllerName.text;
    String email = _controllerEmail.text;

    if (_arquivoImagemSelecionado != null) {
      if (nome.isNotEmpty && nome.length > 6) {
        if (email.isNotEmpty && email.contains("@")) { //EmailValidator.validate(email)
          controllerAuth.registrarUsuarioEmailSenha(nome, email, email,
              tipoUsuario: 'cliente',
              gestor: controllerAuth.usuario!.uid,
              arquivoImagemSelecionado: _arquivoImagemSelecionado,
              logar: false,);

        } else {
          showDialog(context: Get.context!, builder: (ctx) =>AlertDialog(title: Text("Preencha o campos de email com email válido !"),));
        }
      } else {
        showDialog(context: Get.context!, builder: (ctx) =>AlertDialog(title: Text("Nome inválido digite no mínimo 6 caracteres !"),));
      }
    } else {
      showDialog(context: Get.context!, builder: (ctx) =>AlertDialog(title: Text("Selecione uma imagem !"),));
    }
  }

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: PaletaCores.corDark,
          width: larguraTela,
          height: alturaTela,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  height: alturaTela * 0.4,
                  width: larguraTela,
                  color: PaletaCores.corDark,
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
                        width: 550,
                        height: alturaTela * 0.5,
                        child: Padding(
                          padding: EdgeInsets.all(36),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ClipOval(
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
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    OutlinedButton.icon(
                                        onPressed: _selecionarImagem,
                                        icon: Icon(Icons.cached),
                                        label: Text("Selecionar foto")),
                                    SizedBox(height: 10),
                                  ],
                                ),
                                TextField(
                                  keyboardType: TextInputType.name,
                                  controller: _controllerName,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    suffixIcon: Icon(Icons.person_outline),
                                  ),
                                ),
                                TextField(
                                  keyboardType: TextInputType.name,
                                  controller: _controllerEmail,
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      suffixIcon: Icon(Icons.mail_outline)),
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
                                        "Cadastrar",
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
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
