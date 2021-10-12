import 'package:flutter/material.dart';
import '/widgets/Dashboard/pages/overview/widgets/info_card_small.dart';
import '/models/objetivo_model.dart';
import 'package:provider/provider.dart';
import '/models/usuario.dart';

class OverViewCardsSmallScreenDash extends StatelessWidget {
  const OverViewCardsSmallScreenDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarios = Provider.of<List<Usuario>?>(context);
    final projetos = Provider.of<List<ObjetivoModel>?>(context);
    double _width = MediaQuery.of(context).size.width;
    return (usuarios != null)
        ? Container(
            height: 500,
            child: Column(
              children: [
                InfoCardSmallDash(
                  title: 'Numero de Clientes',
                  value: '${usuarios.length}',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(
                  height: _width / 64,
                ),
                InfoCardSmallDash(
                  title: 'Modelos Criados',
                  value: '${projetos!.length}',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(height: _width / 64),
                InfoCardSmallDash(
                  title: 'Numero de Acesso',
                  value: '13',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(height: _width / 64),
                InfoCardSmallDash(
                  title: 'Tempo Medio de Acesso',
                  value: '00:03:00',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(height: _width / 64),
                InfoCardSmallDash(
                  title: 'Numero de Insights',
                  value: '${usuarios.length}',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(height: _width / 64),
                InfoCardSmallDash(
                  title: 'Usuarios Freemiun',
                  value: '${usuarios.length - 4}',
                  onTap: () {},
                  isActive: true,
                ),
                SizedBox(height: _width / 64),
              ],
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
