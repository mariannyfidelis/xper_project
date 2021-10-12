import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Sobre'),
                      //subtitle: Text(''),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Um pouco sobre nossa empresa',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),

                    Card(
                      child: Column(
                        children: [
                          Center(
                              child: ListTile(
                            title: Text('Quem Somos?'),
                            //subtitle: Text(''),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              '''A XPER BRASIL GESTAO EM INOVACAO TECNOLOGICA LTDA é um(a) Sociedade Empresária Limitada de Fortaleza - CE\nfundada em 28/03/2019. Sua atividade principal é Desenvolvimento E Licenciamento De Programas De Computador Customizáveis.''',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Center(
                              child: ListTile(
                            title: Text('Dados da empresa'),
                            //subtitle: Text(''),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              '''Nome Fantasia: XPER BRASIL\nSetor: TECNOLOGIA DA INFORMAÇÃO\nCNPJ: 33.173.492/0001-76\nAtividade Primária (CNAE): DESENVOLVIMENTO E LICENCIAMENTO DE PROGRAMAS DE COMPUTADOR CUSTOMIZÁVEIS\nFundação: 28/03/2019\nLocalização: FORTALEZA - CE\nEndereço: AVENIDA VISCONDE DO RIO BRANCO , 1712, SL-03\nCEP: 60.055-170''',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Center(
                              child: ListTile(
                            title: Text('Nossas Redes Sociais'),
                            //subtitle: Text(''),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Icon(Icons.facebook), //Text(
                            //   '''Instagram''',

                            //   style: TextStyle(
                            //       color: Colors.black.withOpacity(0.6)),
                            //),
                          ),
                        ],
                      ),
                    ),

                    //TODO: quando tiver uma logo colocar aqui
                    //Image(image: AssetImage('')),
                    SizedBox(width: 20, height: 20),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                    SizedBox(width: 20, height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
