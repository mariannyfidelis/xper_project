import 'dart:typed_data';
import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/database/db_firestore.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //String erroMsg = "";
  bool cadastrarUsuario = false;
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerName = TextEditingController();

  Uint8List? _arquivoImagemSelecionado;
  AuthService controllerAuth = Get.find<AuthService>();
  FirebaseFirestore _firestore = DBFirestore.get();

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
    String senha = _controllerPassword.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        if (cadastrarUsuario) {
          if (_arquivoImagemSelecionado != null) {
            if (nome.isNotEmpty && nome.length > 6) {
              controllerAuth.registrarUsuarioEmailSenha(nome, email, senha,
                  arquivoImagemSelecionado: _arquivoImagemSelecionado);
            } else {
              print("Nome inválido digite 6 ou mais caracteres!");
            }
          } else {
            print("Selecione uma imagem !");
          }
        } else {
          //logar usuário
          controllerAuth.logarEmailSenha(email, senha);
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
                                      Expanded(
                                          child: Text("Cadastro Freemium")),
                                      //SizedBox(width: 70),
                                      Visibility(
                                        visible: !cadastrarUsuario,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            controllerAuth.redefinirSenha();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white30),
                                          child: Text(
                                            "Esqueceu sua senha",
                                            style: TextStyle(
                                                color: PaletaCores.corPrimaria),
                                          ),
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
                                        controllerAuth.logarContaGoogle();
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
                                        controllerAuth.logout();
                                        Get.offAll("/");
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: PaletaCores.corPrimaria),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Deslogar",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
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
}
