import '/models/usuario.dart';
import '/models/objetivo_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/Dashboard/pages/overview/widgets/info_card.dart';

class OverViewCardsMediumScreenSizeDash extends StatelessWidget {
  const OverViewCardsMediumScreenSizeDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<List<Usuario>?>(context);
    //final projetos = Provider.of<List<ObjetivoModel>?>(context);
    double _width = MediaQuery.of(context).size.width;
    return (usuarios != null)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  InfoCardDash(
                    title: 'Número de Clientes',
                    value: '${usuarios.length}',
                    onTap: () {},
                    topColor: Colors.orangeAccent,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Modelos Criados',
                    value: '100',
                    onTap: () {},
                    topColor: Colors.lightGreen,
                  ),
                  SizedBox(width: _width / 64),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  InfoCardDash(
                    title: 'Numero de Acesso',
                    value: '13',
                    onTap: () {},
                    topColor: Colors.pink,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Tempo Medio de Acesso',
                    value: '00:03:00',
                    onTap: () {},
                    topColor: Colors.red,
                  ),
                  SizedBox(width: _width / 64),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  InfoCardDash(
                    title: 'Número de Insights',
                    value: '${usuarios.length}',
                    onTap: () {},
                    topColor: Colors.blue,
                  ),
                  SizedBox(width: _width / 64),
                  InfoCardDash(
                    title: 'Usuários Freemiun',
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
