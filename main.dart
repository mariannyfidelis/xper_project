import 'package:firebase_core/firebase_core.dart';

import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

import '/rotas.dart';
import 'package:get/get.dart';
import 'controllers/dados_controller.dart';
import 'utils/paleta_cores.dart';
import '/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/firestoreService.dart';

final ThemeData temaPadrao = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: PaletaCores.corFundo,
  accentColor: PaletaCores.corDestaque,
);

void main() async {
  //Está utilizando o GetX com Obs
  Get.put(MenuControllerDash());
  Get.put(NavigationControllerDash());
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
            create: (context) => firestoreService.getObjetivos(),
            initialData: null),
        StreamProvider(
            create: (context) => firestoreService.getUsuarios(),
            initialData: null)
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Plataforma GOX',
        theme: temaPadrao,
        home: LoginPage(
          title: "App GOX Web - teste",
        ),
        initialRoute: "/login",
        onGenerateRoute: Rotas.gerarRota,
      ),
    );
  }
}
