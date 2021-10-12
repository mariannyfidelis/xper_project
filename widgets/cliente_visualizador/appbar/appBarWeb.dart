import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/cliente_visualizador/objetivos/manipula_niveis.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Plataforma XPER - WebAppbar'),
          Expanded(child: Container()),
          ManipulaNiveisPrimarios(),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0, top: 18.0),
            child: Container(
                height: 30,
                width: 250,
                child: TextField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ))),
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
                FirebaseAuth.instance.signOut();
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
