import 'package:get/get.dart';
import '/screens/home_web.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'screens/cliente_gerenciador_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.find<AuthService>();
    String? tipoUsuario = authService.getTipoUsuario();
    debugPrint("usuário é: ${authService.usuario}");
    debugPrint("isLoging - ${authService.isLoging}");

    if ((authService.isLoging == false) && (authService.usuario == null)) {
      return LoginPage(title: 'Plataforma XPER');
    } else {
      if (tipoUsuario != null) {
        if (tipoUsuario == "admin") {
          return Dashboard();
        } else if (tipoUsuario == "gerenciador") {
          return GerenciadorPage();
        } else if (tipoUsuario == "cliente") {
          return HomeWeb();
        } else {
          return Scaffold(
              body: Center(child: Text("Usuário inexistente :( !")));
        }
      } else {
        return Scaffold(body: Center(child: Container(color: Colors.red)));
      }
    }
  }
}
