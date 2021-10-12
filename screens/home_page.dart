import 'package:flutter/material.dart';
import '/screens/home_mobile.dart';
import '/screens/home_web.dart';
import '/utils/responsivo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Projetos"),),
      body: Responsivo(mobile: HomeMobile(), web: HomeWeb(), /*tablet: HomeTablet(),*/),
    );
  }
}
