import 'package:flutter/material.dart';
import '/widgets/Dashboard/pages/overview/widgets/info_card.dart';
import '/models/objetivo_model.dart';
import '/models/usuario.dart';
import 'package:provider/provider.dart';

class OverviewCardsLargeScreenDash extends StatelessWidget {
  const OverviewCardsLargeScreenDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final usuarios = Provider.of<List<Usuario>?>(context);
    //final projetos = Provider.of<List<ObjetivoModel>?>(context);

    return (usuarios != null)
        ? Column(
            children: [
              Row(
                children: [
                  InfoCardDash(
                    title: 'Numero de Clientes',
                    value: '${usuarios.length}',
                    onTap: () {},
                    topColor: Colors.orangeAccent,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Modelos Criados',
                    value: '13', //'${projetos!.length}',
                    onTap: () {},
                    topColor: Colors.lightGreen,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Numero de Acesso',
                    value: '13',
                    onTap: () {},
                    topColor: Colors.pink,
                  ),
                  SizedBox(width: _width / 64),
                ],
              ),
              SizedBox(height: _width / 64),
              Row(
                children: [
                  InfoCardDash(
                    title: 'Tempo Medio de Acesso',
                    value: '00:03:00',
                    onTap: () {},
                    topColor: Colors.red,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Numero de Insights',
                    value: '${usuarios.length}',
                    onTap: () {},
                    topColor: Colors.blue,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Usuarios Freemiun',
                    value: '${usuarios.length - 4}',
                    onTap: () {},
                    topColor: Colors.amberAccent,
                  ),
                  SizedBox(width: _width / 64),
                ],
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
