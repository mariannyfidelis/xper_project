import 'dart:typed_data';
import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroPage extends StatefulWidget {
  CadastroPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  AuthService controllerAuth = Get.find<AuthService>();
  String erroMsg = "";
  bool cadastrarUsuario = false;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Uint8List? _arquivoImagemSelecionado;

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
        if (email.isNotEmpty && email.contains("@")) {
          //EmailValidator.validate(email)
          (cadastrarUsuario == false)
              ? controllerAuth.registrarUsuarioEmailSenha(
            nome,
            email,
            email,
            tipoUsuario: 'admin',
            gestor: '',
            arquivoImagemSelecionado: _arquivoImagemSelecionado,
            logar: false,
          )
              : controllerAuth.registrarUsuarioEmailSenha(
            nome,
            email,
            email,
            tipoUsuario: 'gerenciador',
            gestor: '',
            arquivoImagemSelecionado: _arquivoImagemSelecionado,
            logar: false,
          );
        } else {
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                title:
                Text("Preencha o campos de email com email válido !"),
              ));
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (ctx) => AlertDialog(
              title: Text("Nome inválido digite no mínimo 6 caracteres !"),
            ));
      }
    } else {
      showDialog(
          context: Get.context!,
          builder: (ctx) => AlertDialog(
            title: Text("Selecione uma imagem !"),
          ));
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
                        width: 650,
                        height: alturaTela * 0.7,
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
                                    //hintText: "Nome",
                                    labelText: "Nome",
                                    suffixIcon: Icon(Icons.person_outline),
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
                                Row(
                                  children: [
                                    Text("Administrador"),
                                    Switch(
                                        value: cadastrarUsuario,
                                        onChanged: (valor) {
                                          setState(() {
                                            cadastrarUsuario = valor;
                                          });
                                        }),
                                    Expanded(
                                        child: Text("Cliente gerenciador")),
                                    //SizedBox(width: 70),
                                  ],
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
