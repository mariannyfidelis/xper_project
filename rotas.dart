import 'models/usuario.dart';
import '/screens/home_page.dart';
import '/utils/paleta_cores.dart';
import '/screens/login_page.dart';
import '/screens/projetos_page.dart';
import '/screens/mensagens_page.dart';
import '/screens/dashboard_page.dart';
import 'package:flutter/material.dart';
import '/screens/redefinicao_senha_page.dart';
import 'screens/projeto_pagina_principal.dart';
import '/screens/cliente_gerenciador_page.dart';

class Rotas {
  static Route<dynamic> gerarRota(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) {
          return LoginPage(title: "Login Page");
        });

      case "/login":
        return MaterialPageRoute(builder: (_) {
          return LoginPage(title: "Login Page");
        });

      case "/home":
        return MaterialPageRoute(builder: (_) {
          return HomePage();
        });

      case "/redefinicaoSenha":
        return MaterialPageRoute(builder: (_) {
          return RedefinicaoSenhaPage();
        });

      case "/mensagens":
        return MaterialPageRoute(builder: (_) {
          return MensagensPage(args as Usuario);
        });

      case "/projetos":
        return MaterialPageRoute(builder: (_) {
          return ProjetoPage();
        });

      case "/gerenciador":
        return MaterialPageRoute(builder: (_) {
          return GerenciadorPage();
        });

      case "/dashboard":
        return MaterialPageRoute(builder: (_) {
          return Dashboard();
        });
    }

    return _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada !"),
        ),
        body: Center(
          child: Text(
            "Tela não encontrada !",
            style: TextStyle(
              color: PaletaCores.errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}

