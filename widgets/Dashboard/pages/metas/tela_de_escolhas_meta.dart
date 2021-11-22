import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/widgets/Dashboard/pages/metas/meta.dart';
import '/widgets/Dashboard/pages/metas/meta_donos.dart';
import '/widgets/Dashboard/pages/metas/meta_objetivos.dart';
import '/widgets/Dashboard/pages/metas/meta_resultados.dart';

class TelaEscolhas extends StatefulWidget {
  const TelaEscolhas({Key? key}) : super(key: key);

  @override
  _TelaEscolhasState createState() => _TelaEscolhasState();
}

class _TelaEscolhasState extends State<TelaEscolhas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child:
              //  Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              //   child:
              Column(children: [
            SizedBox(height: 150),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MetaObjetivos()));
              },
              child: Text('Objetivos Principais',
                  style: TextStyle(fontSize: 23, color: PaletaCores.corLight)),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MetaResultados()));
              },
              child: Text('Resultados Principais',
                  style: TextStyle(fontSize: 23, color: PaletaCores.corLight)),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Meta()));
              },
              child: Text('Métricas Principais',
                  style: TextStyle(fontSize: 23, color: PaletaCores.corLight)),
            ),
            SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MetaDonos()));
              },
              child: Text('Donos',
                  style: TextStyle(fontSize: 23, color: PaletaCores.corLight)),
            ),
            SizedBox(height: 12),
            //),
          ]),
        ),
      ),
    ));
  }
}
