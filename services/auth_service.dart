import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import '/models/usuario.dart';
import '/screens/home_web.dart';
import '/screens/tela_de_aviso.dart';
import '/database/db_firestore.dart';
import '/utils/conversoes_uteis.dart';
import '/screens/dashboard_page.dart';
import 'package:flutter/material.dart';
import '/screens/redefinicao_senha_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

//TODO: errado !!! Configurar para salvar os dados dentro do número correto do projeto
String id_projeto = "01"; //

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance.obs.value;
  User? usuario;
  bool isLoging = false.obs.value;
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
        //isLoading = false;

      } else {
        usuario = user;
        isLoging = true;
        //isLoading = false;
      }
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    isLoging = true;
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
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                    title: Text("Usuário Cadastrado!"),
                  ));
        });
      });
    } else {
      String urlImagem = usuario.urlImagem;
      if (urlImagem != null || urlImagem != "") {
        print("deu certo taí o link $urlImagem!!!");
        final usuariosRef = _firestore.collection("usuarios");
        usuariosRef
            .doc("${usuario.idUsuario}")
            .set(usuario.toMap())
            .then((value) {
        });
      } else {
        print("Arquivo: authservice - linha 96");
        print("entrei no upload mas a url imagem esta vazia");
        print("url imagem ${urlImagem}");
        arquivoSelecionado = convertUint8list();
        if (arquivoSelecionado != null) {
          print("deu certo deu certo deu certo **** -> $urlImagem!!!");
          final usuariosRef = _firestore.collection("usuarios");
          usuariosRef
              .doc("${usuario.idUsuario}")
              .set(usuario.toMap())
              .then((value) {
            //Get.to(() => HomeWeb(tipo: usuario.tipoUsuario));
            //Navigator.pushReplacementNamed(context, "/projetos");
          });
        } else {
          print(
              "mesmo com a conversao ainda ta nulo o arquivo de imagem selecionado !");
        }
      }
    }

    //Criar a estrutura de pastas de um determinado usuário
    criaEstruturaPasta(usuario.idUsuario);
  }

  String? registrarUsuarioEmailSenha(String nome, String email, String senha,
      {Uint8List? arquivoImagemSelecionado,
      String tipoUsuario = "cliente",
      String? gestor = "",
      bool logar = true}) {
    String? idUsuario;

    try {
      _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      )
          .then((userCredencial) {
        if (logar == true) {
          _getUser();
        }
        print("Usuário criado pelo auth-service: $usuario");
        idUsuario = userCredencial.user?.uid;
        //idUsuario = usuario!.uid;
        print("Usuário cadastrado: $idUsuario");

        if (idUsuario != null) {
          Usuario usuario = Usuario(idUsuario!, nome, email,
              gestor: gestor!, tipoUsuario: tipoUsuario, ativo: true);
          _uploadImagem(usuario, arquivoImagemSelecionado!);
          criaEstruturaPasta(idUsuario!);
        } else {
          print("Id veio nulo pro LoginPage .... :(");
        }

        return idUsuario;
      }).catchError((onError) {
        print("Peguei o erro: $onError");
        String errorFirebase = onError.toString().split(" ")[0].split("/")[1];
        errorFirebase = errorFirebase.substring(0, errorFirebase.length - 1);
        print(errorFirebase);
        if (errorFirebase == "email-already-in-use") {
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                    title: Text("Usuário já está cadastrado"),
                  ));
        }
        if (errorFirebase == "weak-password") {
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                    title: Text(
                        "Escolha uma senha mais forte e com no mínimo 6 caracteres!"),
                  ));
        }
        if (errorFirebase == "wrong-password") {
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                    title: Text("A senha não confere !"),
                  ));
        }
        if (errorFirebase == "user-not-found") {
          showDialog(
              context: Get.context!,
              builder: (ctx) => AlertDialog(
                    title: Text("Cadastre-se !"),
                  ));
        }
      });
    } on FirebaseAuthException catch (e) {
      print("--------> ${e.code} <---------");
      if (e.code == 'weak-password') {
        throw AuthException("A senha é fraca !");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta. Tente novamente");
      } else if (e.code == "user-not-found") {
        throw AuthException("Email não encontrado. Cadastra-se!");
      } else if (e.code == "email-already-in-use") {
        print(e.code);
        return e.code;
      }
    }
  }

  registrar(String nome, String email, String senha) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((value) => null)
          .catchError((onError) {
        print("Peguei o erro: $onError");
      });
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException("A senha é fraca !");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta. Tente novamente");
      } else if (e.code == "user-not-found") {
        throw AuthException("Email não encontrado. Cadastra-se!");
      } else if (e.code == "email-already-in-use") {
        print("${e.email}, ${e.tenantId}, ${e.credential}");
        throw AuthException("Este email já está cadastrado !");
      }
    }
  }

  void redefinirSenha() {
    Get.to(() => RedefinicaoSenhaPage());
  }

  void logarEmailSenha(String email, String senha) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((value) async {
      debugPrint(
          "Logado como: ${value.user?.uid} de email: ${value.user?.email}");
      User? usuarioLogado = value.user;

      _getUser();
      verificaTipoUsuario(usuarioLogado);
    }).catchError((onError) {
      print("Peguei o erro: $onError");
      print("Aconteceu algum problema ao logar ...");
      String errorFirebase = onError.toString().split(" ")[0].split("/")[1];
      errorFirebase = errorFirebase.substring(0, errorFirebase.length - 1);
      print(errorFirebase);
      if (errorFirebase == "wrong-password") {
        showDialog(
            context: Get.context!,
            builder: (ctx) => AlertDialog(
                  title: Text("A senha não confere !"),
                ));
      }
      if (errorFirebase == "user-not-found") {
        showDialog(
            context: Get.context!,
            builder: (ctx) => AlertDialog(
                  title: Text("Cadastre-se !"),
                ));
      }
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

      //TODO: Login com a conta do Google tá bugado ,
      //TODO: tem que verificar se o email ta cadastrado e pegar o tipo de usuário.
      //TODO: Caso não esteja cadastrado  entra como cliente !
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
    bool ativo = us.get("ativo");
    print("xxx tipo do usuário $tipoUsuario");

    if (tipoUsuario == "admin" && ativo == true) {
      Get.to(() => Dashboard(tipo: "admin"));
    } else if (tipoUsuario == "gerenciador" && ativo == true) {
      Get.to(() => Dashboard(tipo: "gerenciador"));
    } else if (tipoUsuario == "cliente" && ativo == true) {
      Get.off(HomeWeb(tipo: "cliente"));
    } else if (ativo == false) {
      Get.to(() => TelaDeAviso());
    } else {
      Get.to(() => Scaffold(body: Center(child: CircularProgressIndicator())));
    }
  }

  FirebaseAuth getUser() {
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

  void criaEstruturaPasta(String idUsuario, {String id_projeto = "01"}) {
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

  Future<String?> registrarDono(String nome, String email, String senha,
      {String tipoUsuario = "cliente"}) async {
    String? idUsuario = "";
    Get.find<ControllerProjetoRepository>().addResponsavelPedaco(nome, email);

    try {
      _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      )
          .then((userCredencial) {
        print("Usuário criado pelo auth-service: $idUsuario");
        idUsuario = userCredencial.user?.uid;
        print("Novo usuario 'corporativo - dono' cadastrado: $idUsuario");

        if (idUsuario != null) {
          Usuario usuario = Usuario(idUsuario!, nome, email,
              tipoUsuario: tipoUsuario, ativo: true);

          criaEstruturaPasta(idUsuario!);

          var cont = Get.find<ControllerProjetoRepository>();
          cont.addOneDono(nome, email);
        } else {
          print("Nao foi possivel a criacao de um Dono  .... :(");
        }

        return idUsuario;
        // _auth.currentUser
        //     ?.sendEmailVerification()
        //     .then((value) => print("enviei um email de verificação ..."));
      }).catchError((e) {
        String? erroCode = "";

        if (e.code == 'weak-password') {
          erroCode = e.code;
          return erroCode;
        } else if (e.code == "wrong-password") {
          erroCode = e.code;
          return erroCode;
        } else if (e.code == "user-not-found") {
          erroCode = e.code;
          return erroCode;
        } else if (e.code == "email-already-in-use") {
          erroCode = e.code;
          return erroCode;
        }
      });
    } catch (e) {}
  }

  String? registrarDono2(String nome, String email, String senha,
      {String tipoUsuario = "cliente"}) {
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
}
