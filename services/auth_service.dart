import 'dart:typed_data';
import 'package:get/get.dart';
import '/models/usuario.dart';
import '/screens/home_web.dart';
import '/database/db_firestore.dart';
import '/screens/dashboard_page.dart';
import 'package:flutter/material.dart';
import '/screens/redefinicao_senha_page.dart';
import '/screens/cliente_gerenciador_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

String id_projeto = "01";

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance.obs.value;
  User? usuario;
  bool isLoging = false.obs.value;
  bool isLoading = true.obs.value;
  FirebaseFirestore _firestore = DBFirestore.get();
  FirebaseStorage _storage = FirebaseStorage.instance;

  AuthService() {
    _authCheck();
  }


  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      // usuario = (user == null) ? null : user;

      if (user == null) {
        usuario = null;
        isLoging = false;

      } else {
        usuario = user;
        isLoging = true;
        isLoading = false;
      }
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    isLoging = true;
    isLoading = false;
  }

  void _uploadImagem(Usuario usuario, Uint8List imagem) {
    print("entrei no upload de imagem ....");
    Uint8List? arquivoSelecionado = imagem;

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
          Get.to(HomeWeb());
          //Navigator.pushReplacementNamed(context, "/projetos");
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
        Get.to(HomeWeb());
        //Navigator.pushReplacementNamed(context, "/projetos");
      });
    }

    //Criar a estrutura de pastas de um determinado usuário
    criaEstruturaPasta(usuario.idUsuario);
  }

  String? registrarUsuarioEmailSenha(String nome, String email, String senha,
      {Uint8List? arquivoImagemSelecionado, String tipoUsuario = "cliente"}) {
    String? idUsuario;

    try {
      _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      )
          .then((userCredencial) {
        _getUser();
        print("Usuário criado pelo auth-service: $usuario");
        //idUsuario = userCredencial.user?.uid;
        idUsuario = usuario!.uid;
        print("Usuário cadastrado: $idUsuario");

        if (idUsuario != null) {
          Usuario usuario = Usuario(idUsuario!, nome, email,
              tipoUsuario: tipoUsuario, ativo: true);
          _uploadImagem(usuario, arquivoImagemSelecionado!);
          criaEstruturaPasta(idUsuario!);
        } else {
          print("Id veio nulo pro LoginPage .... :(");
        }
        // _auth.currentUser
        //     ?.sendEmailVerification()
        //     .then((value) => print("enviei um email de verificação ..."));

        return idUsuario;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException("A senha é fraca !");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta. Tente novamente");
      } else if (e.code == "user-not-found") {
        throw AuthException("Email não encontrado. Cadastra-se!");
      } else if (e.code == "email-already-in-use") {
        throw AuthException("Este email já está cadastrado !");
      }
    }
    //_getUser();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException("A senha é fraca !");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta. Tente novamente");
      } else if (e.code == "user-not-found") {
        throw AuthException("Email não encontrado. Cadastra-se!");
      } else if (e.code == "email-already-in-use") {
        throw AuthException("Este email já está cadastrado !");
      }
    }
  }

  void redefinirSenha() {
    print("Redefina sua senha ...");
    Get.to(RedefinicaoSenhaPage());
    //Navigator.pushReplacementNamed(context, "/redefinicaoSenha");
  }

  void logarEmailSenha(String email, String senha) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) async {
      print("Logado como: ${value.user?.uid} de email: ${value.user?.email}");
      User? usuarioLogado = value.user;

      //TODO - Será que precisa ???
      _getUser();
      verificaTipoUsuario(usuarioLogado);
    }).catchError((error) {
      print(error);
      print("Aconteceu algum problema ao logar ...");
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
        //_uploadImagem(usuario);
        //TODO - Será que precisa ???
        //TODO - Tem que criar um usuário no Firestore com os dados do Google
        _getUser();
        print("Logado como google email ${resultado.user?.email}");
      } else {}
    });

    _getUser();
  }

  void logout() {
    _auth.signOut();
    isLoging = false;
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
        await DBFirestore.get().collection("usuarios").doc("$uidUser").get();

    String tipoUsuario = us.get("tipoUsuario");
    print("xxx tipo do usuário $tipoUsuario");

    if (tipoUsuario == "admin") {
      Get.to(Dashboard());
    } else if (tipoUsuario == "gerenciador") {
      Get.to(GerenciadorPage());
    } else if (tipoUsuario == "cliente") {
      Get.to(HomeWeb());
    } else {
      Get.to(Scaffold(body: Center(child: CircularProgressIndicator())));
    }
    // //QuerySnapshot snapshot =
    // //  await _firestore.collection("usuarios/$uidUser").get();
    // if (tipo == "admin") {
    //   //Navigator.pushReplacementNamed(context, "/dashboard");
    // } else if (tipo == "gerenciador") {
    //   //Navigator.pushReplacementNamed(context, "/gerenciador");
    // } else if (tipo == "cliente") {
    //   //Navigator.pushReplacementNamed(context, "/projetos");
    // }
  }

  FirebaseAuth getUser(){
    return _auth;
  }

  String? getTipoUsuario() {
    if (usuario == null) {
      return null;
    } else {
      DBFirestore.get()
          .collection("usuarios")
          .doc(usuario!.uid)
          .get()
          .then((value) {
        Map<String, dynamic>? dados = value.data();

        if (dados != null) {
          Usuario usuarioLogado = Usuario.fromFirestore(dados);
          return usuarioLogado.tipoUsuario;
        } else {
          return null;
        }
      });
    }
  }

  Future<String?> getTipoUsuario2() async {
    //
    if (usuario == null) {
      return null;
    } else {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await DBFirestore.get()
          .collection("usuarios")
          .doc(usuario!.uid)
          .get();

      Map<String, dynamic>? dados = snapshot.data();

      if (dados != null) {
        Usuario usuarioLogado = Usuario.fromFirestore(dados);
        return usuarioLogado.tipoUsuario;
      } else {
        return null;
      }
    }
  }

  void criaEstruturaPasta(String idUsuario) {
    print("entrei para criar uma pasta para um usuário");

    Reference estruturaUser = _storage
        .ref("dados_usuarios/${usuario!.uid}/projetos/$id_projeto/audio/.data");

    Reference estruturaUser2 = _storage.ref(
        "dados_usuarios/${usuario!.uid}/projetos/$id_projeto/images/.data");

    Reference estruturaUser3 = _storage.ref(
        "dados_usuarios/${usuario!.uid}/projetos/$id_projeto/documents/.data");

    UploadTask upload = estruturaUser.putString("data");
    UploadTask upload2 = estruturaUser2.putString("data");
    UploadTask upload3 = estruturaUser3.putString("data");
    upload.whenComplete(() => print("enviei um dado em string"));

    // UploadTask uploadtask = estruturaUser.putData(arquivoSelecionado);
    // uploadtask.whenComplete(() async {
    //   String urlImagem = await uploadtask.snapshot.ref.getDownloadURL();
    //   print("deu certo taí o link $urlImagem!!!");
    //   usuario.urlImagem = urlImagem;
    // });
  }
}
