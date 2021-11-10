import 'package:get/get.dart';
import '/services/auth_service.dart';
import 'package:flutter/material.dart';
import '/widgets/cliente_visualizador/objetivos/manipula_niveis.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerAuth = Get.find<AuthService>();

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.home),
              splashRadius: 14),
          SizedBox(width: 20),
          Text('Plataforma XPER - WebAppbar'),
          Expanded(child: Container()),
          ManipulaOKR(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, top: 18.0),
            child: Container(
              height: 25,
              width: 250,
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                cursorHeight: 15,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        IconButton(
          iconSize: 15,
          splashRadius: 20,
          onPressed: () {},
          icon: Icon(Icons.settings),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.minPositive, double.minPositive),
                  shadowColor: Colors.white54,
                  elevation: 12,
                  backgroundColor: Colors.red),
              onPressed: () {
                //FirebaseAuth.instance.signOut();
                controllerAuth.logout();
                //Get.offAll("/");
                Navigator.popAndPushNamed(context, "/");
              },
              child: Text(
                " Sair ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
        ),
      ],
    );
  }
}
