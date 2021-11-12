import 'package:get/get.dart';
import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';

class TelaDeAviso extends StatelessWidget {
  const TelaDeAviso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double alturaTela = MediaQuery.of(context).size.height;
    double larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: PaletaCores.corPrimaria,
            width: larguraTela,
            height: alturaTela,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: 650,
                    height: alturaTela * 0.7,
                    child: Padding(
                      padding: EdgeInsets.all(36),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                                width: 15,
                              ),
                              Text('Conta Suspensa',
                                  style: TextStyle(fontSize: 50)),
                              SizedBox(
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                  "Para reativar sua conta entre em contato com seu gestor ou um administrador da plataforma",
                                  style: TextStyle(fontSize: 25)),
                              SizedBox(
                                height: 15,
                                width: 15,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('OK', style: TextStyle(fontSize: 18)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
