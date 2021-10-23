import '/screens/home_web.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/screens/projeto_pagina_principal.dart';
import '/widgets/Dashboard/app_bar/custom_text.dart';

class DashVisual extends StatefulWidget {
  const DashVisual({Key? key}) : super(key: key);

  @override
  _DashVisualState createState() => _DashVisualState();
}

class _DashVisualState extends State<DashVisual> {
  @override
  Widget build(BuildContext context) {
    //TODO: verificar o provider.of por get find

    //Get.find<Qual repository>();
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
                text: "Dashboard Vizual",
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
                text: "Criar Novo Projeto",
                color: PaletaCores.active.withOpacity(.7),
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
