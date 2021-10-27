import '/auth_check.dart';
import 'package:get/get.dart';
import 'utils/paleta_cores.dart';
import '/screens/home_web.dart';
import '/screens/login_page.dart';
import 'screens/dashboard_page.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/firestoreService.dart';
import 'controllers/dados_controller.dart';
import 'screens/redefinicao_senha_page.dart';
import 'screens/cliente_gerenciador_page.dart';
import 'screens/projeto_pagina_principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';
import 'widgets/Dashboard/pages/resultados/dropDownObjetivo.dart';

final ThemeData temaPadrao = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: PaletaCores.corFundo,
  accentColor: PaletaCores.corDestaque,
);

void main() async {

  Get.put(AuthService());
  Get.put(MenuControllerDash());
  Get.put(NavigationControllerDash());
  Get.put(ControllerProjetoRepository());
  Get.put(DropObjetivoEResultado());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ObjectiveController()),
        StreamProvider(
            create: (context) => firestoreService.getUsuarios(),
            initialData: null)
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        defaultTransition: Transition.native,
        locale: Locale('pt', 'BR'),
        title: 'Plataforma XPER',
        theme: temaPadrao,
        home: AuthCheck(),
        getPages: [
          GetPage(
            name: "/",
            page: () => LoginPage(title: 'Plataforma XPER'),
          ),
          GetPage(
            name: "/dashboard",
            page: () => Dashboard(),
          ),
          GetPage(
            name: "/gerenciador",
            page: () => GerenciadorPage(),
          ),
          GetPage(
            name: "/redefinicaoSenha",
            page: () => RedefinicaoSenhaPage(),
          ),
          GetPage(
            name: "/projetos",
            page: () => ProjetoPage(),
          ),
          GetPage(
            name: "/home",
            page: () => HomeWeb(),
          ),
        ],
      ),
    );
  }
}
