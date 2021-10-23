import 'package:xper_brasil_projects/services/auth_service.dart';

import '/rotas.dart';
import 'package:get/get.dart';
import 'utils/paleta_cores.dart';
import '/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/firestoreService.dart';
import 'controllers/donoRepository.dart';
import 'controllers/dados_controller.dart';
import 'controllers/objetivoRepository.dart';
import '/controllers/metricasRepository.dart';
import '/controllers/projectsRepository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/resultadoPrincipalRepository.dart';
import 'widgets/Dashboard/controller/controllers_dash.dart';
import '/widgets/Dashboard/controller/menu_controller_dash.dart';
import '/widgets/Dashboard/controller/navigation_controller_dash.dart';

final ThemeData temaPadrao = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: PaletaCores.corFundo,
  accentColor: PaletaCores.corDestaque,
);

void main() async {

  //TODO: AuthService
  Get.put(AuthService());
  Get.put(MenuControllerDash());
  Get.put(NavigationControllerDash());
  Get.put(ObjetivosPrincipaisRepository());//
  Get.put(DonoRepository());//
  Get.put(MetricasRepository());//
  Get.put(ResultadoPrincipalRepository());//
  Get.put(ProjectsRepository());
  Get.put(ControllerProjetoRepository());

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
        title: 'Plataforma XPER',
        theme: temaPadrao,
        home: LoginPage(
          title: "App XPER Web",
        ),
        initialRoute: "/login",
        onGenerateRoute: Rotas.gerarRota,
      ),
    );
  }
}
