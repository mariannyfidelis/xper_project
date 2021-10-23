import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/database/db_firestore.dart';
import '/screens/login_page.dart';
import '/services/auth_service.dart';
import 'screens/dashboard_page.dart';
import 'screens/projeto_pagina_principal.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context){
    AuthService auth = Get.find<AuthService>();

    if (auth.isLoading) {
      return loading();
    }else if (auth.usuario == null) {
      return LoginPage(title: "title- auth service");
    }else{
      //verificaTipoUsuario(auth.usuario);
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

  }

  Widget loading() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Future<Widget> verificaTipoUsuario(User? user) async {
    //Verificar e redirecionar para a tela específica
    if(user==null){
      return Scaffold(body: Center(child: LinearProgressIndicator()));
    }else{
      String uidUser = user!.uid;
      DocumentSnapshot us =
      await DBFirestore.get().collection("usuarios").doc("$uidUser").get();

      String tipo = us.get("tipoUsuario");
      print("xxx tipo do usuário $tipo");

      //QuerySnapshot snapshot =
      //  await _firestore.collection("usuarios/$uidUser").get();
      if (tipo == "admin") {
        //Navigator.pushReplacementNamed(context, "/dashboard");
        return Dashboard();
      } else if (tipo == "gerenciador") {
        Navigator.pushReplacementNamed(context, "/gerenciador");
        return Dashboard();
      } else if (tipo == "cliente") {
        Navigator.pushReplacementNamed(context, "/projetos");
        return ProjetoPage();
      }else{
        return Scaffold(body: Center(child: LinearProgressIndicator()));
      }
    }
  }
}
