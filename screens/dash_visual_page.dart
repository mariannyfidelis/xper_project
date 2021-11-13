import 'package:get/get.dart';
import '/screens/home_web.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/screens/projeto_pagina_principal.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';
import '/widgets/Dashboard/controller/controllers_dash.dart';

class DashVisual extends StatefulWidget {
  final String? tipo;
  const DashVisual({Key? key, this.tipo}) : super(key: key);

  @override
  _DashVisualState createState() => _DashVisualState();
}

class _DashVisualState extends State<DashVisual> {
  @override
  Widget build(BuildContext context) {
    final controllerProjetos = Get.find<ControllerProjetoRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Virtual"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(25),
        crossAxisSpacing: 10,
        mainAxisSpacing: 3,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Diretoria',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProjetoPage()));
                  },
                  icon: Image.asset('images/okr.jpeg'),
                  iconSize: 250,
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Comercial',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProjetoPage()));
                  },
                  icon: Image.asset('images/okr.jpeg'),
                  iconSize: 250,
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('TI',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProjetoPage()));
                  },
                  icon: Image.asset('images/okr.jpeg'),
                  iconSize: 250,
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Insights',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('45',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 85,
                ),
                Center(
                  child: Text('Ações',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('123',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Insights',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('15',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 85,
                ),
                Center(
                  child: Text('Ações',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('23',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Insights',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('35',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 85,
                ),
                Center(
                  child: Text('Ações',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('12',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Projetos',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('123',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Projetos',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('23',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Center(
                  child: Text('Projetos',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Text('12',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('clique para ver',
                      style:
                          TextStyle(color: PaletaCores.corLight, fontSize: 20)),
                )
              ],
            ),
            color: PaletaCores.corDark,
          ),
        ],
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(
            width: 25,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: PaletaCores.active, width: .5),
                color: PaletaCores.corLight,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PaletaCores.corLight,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              onPressed: () {
                //Get.to(HomeWeb());
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeWeb()));
              },
              child: CustomText(
                text: "Listar Projetos",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: PaletaCores.active, width: .5),
                color: PaletaCores.corLight,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PaletaCores.corLight,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              onPressed: () {},
              child: CustomText(
                text: "Dashboard Visual",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: PaletaCores.active, width: .5),
                color: PaletaCores.corLight,
                borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Obx(() => Visibility(
                visible: controllerProjetos.ocultaCriarProjeto(widget.tipo!),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PaletaCores.corLight,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                  ),
                  onPressed: () {
                    controllerProjetos.addOneProject("Projeto Padrão");
                  },
                  child: CustomText(
                    text: "Criar Novo Projeto",
                    color: PaletaCores.active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                ))),
          ),
        ],
      ),
    );
  }
}
