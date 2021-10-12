import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/usuario.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({Key? key}) : super(key: key);

  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String idUsuarioLogado;

  Future<List<Usuario>> _recuperarContatos() async {

    final usuarioRef = _firestore.collection("usuarios");

    QuerySnapshot querySnapshot = await usuarioRef.get();

    List<Usuario> listausuarios = [];
    //Percorrer os itens
    for (DocumentSnapshot item in querySnapshot.docs) {
      String idUsuario = item["idUsuario"];

      if (idUsuario == idUsuarioLogado) continue;

      String email = item["email"];
      String nome = item["nome"];
      String urlImagem = item["urlImagem"];
      Usuario usuario = Usuario(idUsuario, nome, email, urlImagem: urlImagem);
      listausuarios.add(usuario);
    }

    return listausuarios;
  }

  _recuperarDadosUsuarioLogado() async {
    User? usuarioAtual = _auth.currentUser;
    if (usuarioAtual != null) {
      setState(() {
        idUsuarioLogado = usuarioAtual.uid;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Usuario>>(
        future: _recuperarContatos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: [
                    Text("Carregando contatos ..."),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text("Erro ao carregar dados !"));
              } else {
                List<Usuario>? listaUsuarios = snapshot.data;
                if (listaUsuarios != null) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.transparent,
                        thickness: 0.2,
                      );
                    },
                    itemCount: listaUsuarios.length,
                    itemBuilder: (context, index) {
                      Usuario usuario = listaUsuarios[index];

                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "/mensagens", arguments: usuario);
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              CachedNetworkImageProvider(usuario.urlImagem),
                        ),
                        title: Text("${usuario.nome}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        contentPadding: EdgeInsets.all(10),
                      );
                    },
                  );
                }

                return Center(child: Text("Nenhum contato encontrado !"));
              }
          }
        });
  }
}
