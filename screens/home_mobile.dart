import '/utils/paleta_cores.dart';
import 'package:flutter/material.dart';
import '/components/lista_contatos.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: PaletaCores.corPrimaria,
          title: Text(
            "Tela Principal Projetos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            ),
            SizedBox(
              width: 3.0,
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(
                Icons.login_outlined,
                color: Colors.red,
              ),
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.white30,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            tabs: [
              Tab(
                text: "Conversas",
              ),
              Tab(
                text: "Contatos",
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Center(
                child: Text("Conversas"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListaContatos(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
